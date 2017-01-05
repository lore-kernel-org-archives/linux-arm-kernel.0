From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:14:27 +0100
Subject: [PATCH v3] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161227102807.20244-1-manu@bidouilliste.com>
References: <20161227102807.20244-1-manu@bidouilliste.com>
Message-ID: <20170105171427.v4vosv7mfv3zveyz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 11:28:07AM +0100, Emmanuel Vadot wrote:
> The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
> others three only have 1.
> Add the num-cs property to each node.
> The current driver doesn't read this property but this is useful for
> downstream user of DTS (FreeBSD for example).
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/1f29aa7b/attachment.sig>
