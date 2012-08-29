From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 29 Aug 2012 10:56:01 +0300
Subject: [PATCH 1/1] mxc_nand : allow swapping the Bad block Indicator
 for NFC v1.
In-Reply-To: <1345825064-9147-1-git-send-email-gcembed@gmail.com>
References: <1345811288.2848.308.camel@sauron.fi.intel.com>
 <1345825064-9147-1-git-send-email-gcembed@gmail.com>
Message-ID: <1346226961.2848.424.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-24 at 18:17 +0200, Ga?tan Carlier wrote:
> Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
> in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
> Warning: The same solution needs to be applied to the boot loader and the
> flash programmer.
> 
> This is a modified version of patch sent by J?rgen Lambrecht :
> [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block Indicator,
> and use for imx27pdk nand support.

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120829/125da8ea/attachment.sig>
