From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Aug 2015 09:55:48 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20150824095548.6bb25c3a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  drivers/cpufreq/exynos-cpufreq.c

between commit:

  62c3f2fddd43 ("cpufreq: exynos: Fix for memory leak in case SoC name does not match")

from Linus' tree and commits:

  ac4c90c82e4d ("cpufreq: exynos: remove exynos5250 specific cpufreq driver support")
  966f2a71a92d ("cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support")

from the arm-soc tree.

I fixed it up (the latter commit removed the file, so I did that) and
can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
