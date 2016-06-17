From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 18:56:10 -0700
Subject: [GIT PULL 2/7] Broadcom soc-arm64 changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1466128575-5378-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/soc-arm64

for you to fetch changes up to 9c7a68017503eda3071ba8647bd0b4c716f18c74:

  arm64: vulcan: enable GPIOLIB in Kconfig (2016-05-31 10:52:25 -0700)

----------------------------------------------------------------
This pull request contains SoC changes for Broadcom ARM64-based SoCs:

- Kamlakant updates the Broadcom Vulcan Kconfig entry with GPIOLIB to enable
  GPIO on these platforms

----------------------------------------------------------------
Kamlakant Patel (1):
      arm64: vulcan: enable GPIOLIB in Kconfig

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
