From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 20:55:17 +0100
Subject: [PATCH] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161122170616.29557-1-manu@bidouilliste.com>
References: <20161122170616.29557-1-manu@bidouilliste.com>
Message-ID: <20161124195517.qrq7briu3pwjnp4n@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 06:06:16PM +0100, Emmanuel Vadot wrote:
> The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
> others three only have 1.
> Add the num-cs property to each node.
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>

I don't think we have any code that uses it at the moment. What is the
rationale behind this patch?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/e1729b42/attachment.sig>
