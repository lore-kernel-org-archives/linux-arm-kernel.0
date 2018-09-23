From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2018 06:28:02 -0700
Subject: [GIT PULL 2/3] Broadcom devicetree changes for 4.20
In-Reply-To: <20180914235928.20551-2-f.fainelli@gmail.com>
References: <20180914235928.20551-1-f.fainelli@gmail.com>
 <20180914235928.20551-2-f.fainelli@gmail.com>
Message-ID: <20180923132802.noldxjzszxjpdznu@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 14, 2018 at 04:59:27PM -0700, Florian Fainelli wrote:
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/devicetree
> 
> for you to fetch changes up to ab0b47d2eff413d60b0a1fc0c1f87f87f0d7f375:
> 
>   ARM: dts: bcm: Fix SPI bus warnings (2018-09-13 15:09:10 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree changes
> for 4.20, please pull the following:
> 
> - Rafal updates the Broadcom BCM5301x (Northstar) DTS files to use the
>   new style partition parser and removes the unsupported/undocumented
>   linux,part-probe properties that were previously introduced
> 
> - Stefan adds supports for the Raspberry Pi Compute Module 3/3Lite, he
>   also updates the Raspberry Pi 3B+ USB Ethernet adapter to have proper
>   LED configuration
> 
> - Rob fixes a bunch of SPI bus warnings in the Northstar Plus and
>   Hurricane 2 DTS files
> 
> - Florian documents the Broadcom roboswitch Switch Register Access Block
>   (SRAB) interrupts, adds the switch interrupts to the Northstar Plus
>   DTS include file and finally updates the BCM958625HR reference board to
>   have the proper SFP module definition

This is probably the upper limit on amount of material that's easy to get
an overview in a patch description written in this format. If you have
more than this, I'd recommend considering dropping some of the attribution
and focus more on brief descriptions on the added functionality.

Attributing contributions is of course important, and we should figure
out good ways of doing that all the way up the tree, but for the tag
itself I find that it can get too verbose.


Merged, thanks!

-Olof
