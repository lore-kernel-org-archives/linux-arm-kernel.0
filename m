From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Jan 2016 13:24:15 +0100
Subject: [PATCH] ARM: tegra: remove redundant ARM_L1_CACHE_SHIFT_6 select
In-Reply-To: <1453539330-11903-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453539330-11903-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160125122415.GB20452@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 05:55:30PM +0900, Masahiro Yamada wrote:
> These two are both ARMv7 SoCs.  They need not explicitly select
> ARM_L1_CACHE_SHIFT_6 because it is enabled along with CPU_V7.
> 
> Refer to commit a092f2b15399 ("ARM: 7291/1: cache: assume 64-byte L1
> cachelines for ARMv7 CPUs").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/soc/tegra/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/ac233e43/attachment.sig>
