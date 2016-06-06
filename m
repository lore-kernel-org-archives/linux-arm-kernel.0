From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 06 Jun 2016 14:25:27 +0200
Subject: [GIT PULL 2/8] arm64: exynos: Mach/soc changes for v4.8
In-Reply-To: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
References: <1465215933-22709-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1465215933-22709-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.8

for you to fetch changes up to 3b3428e384b7aff6093d1a6773027c9095182c6b:

  arm64: exynos: Select SOC specific drivers (2016-05-30 08:44:33 +0200)

----------------------------------------------------------------
Samsung arm64 update for v4.8:
1. Select drivers/soc/samsung.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      arm64: exynos: Select SOC specific drivers

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
