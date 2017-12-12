From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Dec 2017 09:32:02 +0100
Subject: [PATCH 3/4] ARM: dts: sun8i: a83t: Add I2C device nodes and
 pinmux settings
In-Reply-To: <20171212081148.9194-4-wens@csie.org>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-4-wens@csie.org>
Message-ID: <20171212083202.3ivypgnv77bncz4a@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 12, 2017 at 04:11:47PM +0800, Chen-Yu Tsai wrote:
> +		i2c0: i2c at 1c2ac00 {
> +			compatible = "allwinner,sun6i-a31-i2c";

Same remark than for Mylene's patch here, you should have a per-SoC
compatible first.

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/4e78d8eb/attachment.sig>
