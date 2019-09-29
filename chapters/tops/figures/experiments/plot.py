#!/usr/bin/env python2

from matplotlib import rcParams
from matplotlib.ticker import FuncFormatter
import matplotlib.pyplot as plt
import numpy as np

filename = 'out.eps'
saved = 0.03

rcParams.update({'font.size': 14,
                 'legend.labelspacing': 0.2,
                 'font.family': 'Nimbus Sans L'})

fig = plt.figure()
plt.xticks(np.arange(0, 1.01, 0.1))

rivest = lambda removed: 1 if removed <= saved else 1 - (removed - saved)
mixslice = lambda removed: 1 if removed <= saved else 0

xs = [0, saved, saved + 0.00001, 0.3]

# plt.plot(xs[:3:2], map(rivest, xs[:3:2]), color='red', ls='--', lw=2)
plt.plot(xs, map(rivest, xs), color='red', lw=2)
plt.plot(xs, map(mixslice, xs), color='blue', lw=2)
plt.fill_between(xs, map(rivest, xs), color='None', lw=0, edgecolor='red', hatch='\\\\')
plt.fill_between(xs, map(mixslice, xs), color='None', lw=0, edgecolor='blue', hatch='//')

plt.fill_between([-2, -1], [-2, -1], color='None', edgecolor='red', hatch='\\\\', label="Rivest's AONT")
plt.fill_between([-2, -1], [-2, -1], color='None', edgecolor='blue', hatch='//', label="Mix&Slice")

plt.xlim(0, xs[-1])
plt.ylim(0, 1)
plt.xlabel('% removed data')
plt.ylabel('% recovered file')

plt.legend(loc='upper right', frameon=False,
           prop={'size': 14, 'family': 'Nimbus Sans L'})

plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, _: '{:.0%}'.format(x)))
plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda y, _: '{:.0%}'.format(y)))

plt.gca().tick_params(axis='both', which='major', pad=15)
fig.set_tight_layout(True)

plt.savefig('out.eps')
