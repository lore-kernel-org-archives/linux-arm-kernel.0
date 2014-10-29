From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Oct 2014 17:15:37 +0100
Subject: [GIT PULL 2/2] cpufreq-dt platform device
In-Reply-To: <8735180.PYWUSJW9sD@diego>
References: <8735180.PYWUSJW9sD@diego>
Message-ID: <5165858.6mpQCFJLYm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this pull contains the cpufreq-dt device creation needed for cpu frequency
scaling on Rockchip platforms.

While this is only a single patch, there are more soc-changes in the pipeline
(rk3288-smp and suspend) that'll hopefully marture in time for 3.19, so this
probably should get a separate branch in arm-soc and not be merge into the
dt-branch.


Thanks
Heiko


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-soc1

for you to fetch changes up to d3bafa3c09592448358887cfc722f72932134950:

  ARM: rockchip: add a cpufreq-dt device (2014-10-20 11:57:56 +0200)

----------------------------------------------------------------
Add a cpufreq-dt platform device

----------------------------------------------------------------
Heiko Stuebner (1):
      ARM: rockchip: add a cpufreq-dt device

 arch/arm/mach-rockchip/rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)
