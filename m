From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 17:12:06 +0200
Subject: [PATCH 6/7] arm64: allwinner: h6: add R_I2C controller
In-Reply-To: <20180503183847.11046-7-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-7-icenowy@aosc.io>
Message-ID: <20180504151206.c6oi7vtaskg4sbys@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:46AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_I2C controller wired to the PL0/PL1 pins, which
> are used in the reference design to connect AXP805 PMIC.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Dropped the headers (that should have been in your previous patch to
maintain the bisectability) and changed for indices, and applied.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/388bbe10/attachment-0001.sig>
