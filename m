From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 11 May 2018 14:43:37 -0700
Subject: [GIT PULL 4/5] Broadcom drivers changes for 4.18
In-Reply-To: <20180511214339.24139-1-f.fainelli@gmail.com>
References: <20180511214339.24139-1-f.fainelli@gmail.com>
Message-ID: <20180511214339.24139-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/drivers

for you to fetch changes up to b1d0973e9a1b4742ec80f3cf59ecc84a0998465b:

  memory: brcmstb: dpfe: Remove need for dpfe_dev (2018-05-09 12:15:26 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
for 4.18, please pull the following:

- Florian removes the synthetic struct device in the DPFE driver which
  was used to attach sysfs attributes and uses the platform_device we are
  probed from instead.

----------------------------------------------------------------
Florian Fainelli (1):
      memory: brcmstb: dpfe: Remove need for dpfe_dev

 drivers/memory/brcmstb_dpfe.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)
