import pandas as pd
import matplotlib.pyplot as plt
import researchpy as rp
import statsmodels.api as sm
from statsmodels.formula.api import ols
import scipy.stats as stats
from statsmodels.stats.multicomp import pairwise_tukeyhsd
from statsmodels.stats.multicomp import MultiComparison

data_frame = pd.read_csv('/home/normie/Documents/advent/2020-1-23-HMB312-Lab3-AM-PlaqueCount.csv')
data_frame = data_frame.drop('Group # ', axis=1)
data_frame = data_frame.drop('TA', axis=1)
data_frame = data_frame.rename(columns={'Hippocampus Amyloid Counts': 'hippocampus', 'Cerebellum Amyloid Counts': 'cerebellum', 'Cortex Amyloid Counts': 'cortex'})

hipposummary = rp.summary_cont(data_frame['hippocampus'].groupby(data_frame['Slide']))
print(hipposummary)
cortexsummary = rp.summary_cont(data_frame['cortex'].groupby(data_frame['Slide']))
print(cortexsummary)
cerebsummary = rp.summary_cont(data_frame['cerebellum'].groupby(data_frame['Slide']))
print(cerebsummary)

hipresults = ols('hippocampus ~ C(Slide)', data=data_frame).fit()
hip_table = sm.stats.anova_lm(hipresults, typ=2)

cerresults = ols('cerebellum ~ C(Slide)', data=data_frame).fit()
cer_table = sm.stats.anova_lm(cerresults, typ=2)

cortresults = ols('cortex ~ C(Slide)', data=data_frame).fit()
cort_table = sm.stats.anova_lm(cortresults, typ=2)

print('HIPPOCAMPUS')
hipmc = MultiComparison(data_frame['hippocampus'], data_frame['Slide'])
hipmc_results = hipmc.tukeyhsd()
print(hipmc_results)
print('')

print('CEREBELLUM')
cermc = MultiComparison(data_frame['cerebellum'], data_frame['Slide'])
cermc_results = cermc.tukeyhsd()
print(cermc_results)
print('')

print('CORTEX')
cortmc = MultiComparison(data_frame['cortex'], data_frame['Slide'])
cortmc_results = cortmc.tukeyhsd()
print(cortmc_results)
