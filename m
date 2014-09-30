From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 30 Sep 2014 12:15:59 +0200
Subject: [GIT PULL v2 2/2] ARM: rockchip: cpufreq-cpu0 device
In-Reply-To: <201717175.L17Ccvmpek@phil>
References: <7172632.O1FfdvXn6k@phil> <201717175.L17Ccvmpek@phil>
Message-ID: <1712743.HcKV7iIeyP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

this is a version 2 of the cpufreq platform-device addition, as cpufreq-cpu0
was meanwhile renamed to cpufreq-dt, as reported by Viresh Kumar.

So please pull


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-cpufreqdev-v2

for you to fetch changes up to 3eb79a5a9d46b32f63f6b9cd86f9b2bba43e127a:

  ARM: rockchip: honor renaming of cpufreq-cpu0 to cpufreq-dt (2014-09-30 10:33:27 +0200)

----------------------------------------------------------------
Add cpufreq-dt platform device for cpu frequency scaling.

----------------------------------------------------------------
Heiko Stuebner (2):
      ARM: rockchip: add a cpufreq-cpu0 device
      ARM: rockchip: honor renaming of cpufreq-cpu0 to cpufreq-dt

 arch/arm/mach-rockchip/rockchip.c | 7 +++++++
 1 file changed, 7 insertions(+)
