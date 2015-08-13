From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Aug 2015 16:18:41 +0200
Subject: [PATCH] soc: tegra: remove redundant $(CONFIG_ARCH_TEGRA) in
 Makefile
In-Reply-To: <1438322301-24584-1-git-send-email-yamada.masahiro@socionext.com>
References: <1438322301-24584-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150813141840.GB26559@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 02:58:21PM +0900, Masahiro Yamada wrote:
> Kbuild descends into drivers/soc/tegra/ only when CONFIG_ARCH_TEGRA
> is enabled. (see drivers/soc/Makefile)
> 
> $(CONFIG_ARCH_TEGRA) in drivers/soc/tegra/Makefile always evaluates
> to 'y'.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/soc/tegra/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/7536bad6/attachment.sig>
