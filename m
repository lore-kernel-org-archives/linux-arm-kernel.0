From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Nov 2017 09:02:44 +0100
Subject: [PATCH RESEND] clk: sunxi-ng: a83t: Fix i2c buses bits
In-Reply-To: <20171105165134.5199-1-mylene.josserand@free-electrons.com>
References: <20171105165134.5199-1-mylene.josserand@free-electrons.com>
Message-ID: <20171106080244.jz55hkhjgkzutx7x@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 05, 2017 at 05:51:34PM +0100, Myl?ne Josserand wrote:
> i2c1 and i2c2 bits for CCU are not bit 0 but bit 1 and bit 2.
> Because of that, the i2c0 (bit 0) was not correctly configured.
> Fixed the correct bits for i2c1 and i2c2.
> 
> Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Stephen, can you merge it directly? It's not super urgent since we
don't have i2c enabled for that SoC yet, so it can definitely be in
4.15.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171106/3d66dcca/attachment.sig>
