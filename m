From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 27 Feb 2018 16:51:30 -0800
Subject: [GIT PULL 2/2] Broadcom drivers fixes for 4.16
In-Reply-To: <20180228005130.31856-1-f.fainelli@gmail.com>
References: <20180228005130.31856-1-f.fainelli@gmail.com>
Message-ID: <20180228005130.31856-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.16/drivers-fixes

for you to fetch changes up to fee5f1ef6cf76f87d9799596d06979c9e6589f2b:

  memory: brcmstb: dpfe: support new way of passing data from the DCPU (2018-02-23 10:56:59 -0800)

----------------------------------------------------------------
This pull request contains Broadcom SoCs drivers fixes for 4.16, please
pull the following:

- Markus provides two minor fixes to the Broadcom STB DPFE driver, one
  to properly mask bits, and a second one to use the correct type. The
  third commit is a consequence of a newer DFPE firmware which would
  unfortunately crash without appropriate kernel changes.

----------------------------------------------------------------
Markus Mayer (3):
      memory: brcmstb: dpfe: properly mask vendor error bits
      memory: brcmstb: dpfe: fix type declaration of variable "ret"
      memory: brcmstb: dpfe: support new way of passing data from the DCPU

 drivers/memory/brcmstb_dpfe.c | 74 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)
