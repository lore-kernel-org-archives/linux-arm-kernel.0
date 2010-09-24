From: r65037@freescale.com (Richard Zhu)
Date: Fri, 24 Sep 2010 11:43:04 +0800
Subject: [4-0] Serial patchs that upstream fsl i.MX MX51 sdhci driver
Message-ID: <1285299788-32209-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
Here are the patches that I changed the codes refer to your previous comments.
The data IO and WP func are verified on the i.MX51 BBG board.

The missing bits of the HOST_CONTROL and so on had been complemented in 4-3 patch.

Hi Uwe:
The MSL specifed part code is still on-going.
I would change them to the "dynamically allocated method" later.

Any review/comments and suggestions are appreciated.
Thanks in advanced.
[4-1] sdhci/sdhci-pltfm common codes modifications when support FSL eSDHC driver.
[4-2] MX51 MSL codes modification.
[4-3] i.MX sdhci driver seperated from MPC esdhc driver.
[4-4] board config
