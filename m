From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 22 May 2018 14:34:30 +0200
Subject: [PATCH 3/9] ARM: dts: stout: Drop MTD partitioning from DT
In-Reply-To: <20180522120257.13232-3-marek.vasut+renesas@gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
 <20180522120257.13232-3-marek.vasut+renesas@gmail.com>
Message-ID: <20180522123430.ogiv2dxpv2jp3ejw@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 02:02:51PM +0200, Marek Vasut wrote:
> Drop the MTD partitioning from DT, since it does not describe HW
> and to give way to a more flexible kernel command line partition
> passing.
> 
> To retain the original partitioning, assure you have enabled
> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
> following to your kernel command line:
> 
>   mtdparts=spi0.0:512k at 0(loader),256k(uboot),256k(uboot-env),-(flash)
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc at vger.kernel.org

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/9bdaa974/attachment-0001.sig>
