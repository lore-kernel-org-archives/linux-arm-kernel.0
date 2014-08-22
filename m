From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Aug 2014 13:53:08 -0400
Subject: [PATCH] ARM: mvebu: update v7 defconfig with useful options
In-Reply-To: <1408729202-11064-1-git-send-email-olof@lixom.net>
References: <1408729202-11064-1-git-send-email-olof@lixom.net>
Message-ID: <20140822175308.GZ12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Fri, Aug 22, 2014 at 10:40:02AM -0700, Olof Johansson wrote:
> Turn on a bunch of options to make my cubox bootable/usable:
> 
> PRINTK_TIME
> EXT4 (and turn off 2/3 since 4 can mount all filesystems)
> MV643XX_ETH for Dove
> SDHCI for Dove
> DEVTMPFS
> PACKET and UNIX protocol support
> 
> Much of the other churn is just due to reorderings in the defconfig
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/configs/mvebu_v7_defconfig |   67 ++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)

Applied to mvebu/defconfig.  It'll be in -next for Stephen's next run
(Sunday night, hopefully).

thx,

Jason.
