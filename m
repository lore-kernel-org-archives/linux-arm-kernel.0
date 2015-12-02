From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:38 +0900
Subject: [GIT PULL 1/9] ARM: EXYNOS: dts: Syscon dependency for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

The DT changes are needed before switching to syscon-based reboot
and power off method.

Best regards,
Krzysztof



The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-syscon-restart-4.5

for you to fetch changes up to 35135f4b95f03be7ebbf31221ce738f1ec0faa02:

  ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 (2015-11-20 15:58:44 +0900)

----------------------------------------------------------------
Device Tree changes adding necessary nodes for syscon reboot/poweroff
handlers on Exynos boards. The mach-exynos changes must base on top
of this to retain the bisectability of not loosing reboot/poweroff
features.

----------------------------------------------------------------
Alim Akhtar (4):
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos3250
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos4
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5410

 arch/arm/boot/dts/exynos3250.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/exynos5.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi | 14 ++++++++++++++
 4 files changed, 56 insertions(+)
