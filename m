From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 30 Jul 2018 10:26:31 +0200
Subject: [PATCH v3 1/4] arm64: dts: allwinner: a64: Add SID node
In-Reply-To: <20180727115205.20955-1-manu@freebsd.org>
References: <20180727115205.20955-1-manu@freebsd.org>
Message-ID: <20180730082631.es2fbqce5uabi5jc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 01:52:02PM +0200, Emmanuel Vadot wrote:
> The A64 have a SID controller which consist of EFUSE (starting at 0x200)
> and three registers to read/write some of the protected efuses.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Queued all 4 for 4.20, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/01a13c7d/attachment.sig>
