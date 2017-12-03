From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 16:57:18 -0800
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.15
In-Reply-To: <20171127200817.32647-1-f.fainelli@gmail.com>
References: <20171127200817.32647-1-f.fainelli@gmail.com>
Message-ID: <20171203005718.pphlvn2nnea7kwe7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 12:08:17PM -0800, Florian Fainelli wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/devicetree-fixes-1
> 
> for you to fetch changes up to babd8a3e31fbb0abb4c37ee3548974732080b996:
> 
>   Merge tag 'bcm2835-dt-next-fixes-2017-11-15' into devicetree/fixes (2017-11-27 11:28:23 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree fixes for 4.15,
> please pull the following:
> 
> - Stefan provides a fix for the BCM2835 (Raspberry Pi) to fix warnings about
>   missing "#phy-cells" properties
> 
> - Florian provides two fixes for Nortsthar Plus, one that uses the correct
>   interrupt specifiers for the timer/watchdog and one that disables SATA
>   on BCM9582**HR boards since that leads to unidentified hangs right now

Merged, thanks.

-Olof
