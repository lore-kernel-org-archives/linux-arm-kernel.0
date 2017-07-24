From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 10:20:22 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Add I2S0 pinctrl settings
In-Reply-To: <20170722064313.7535-1-codekipper@gmail.com>
References: <20170722064313.7535-1-codekipper@gmail.com>
Message-ID: <20170724082022.wpeqrxjayqnpiw2p@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On Sat, Jul 22, 2017 at 08:43:13AM +0200, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The A20 SoC has a couple of i2s blocks. This patch adds
> the pinctrl settings for block i2s0.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

We're not adding pin groups that are not used by anyone. If you have a
board using them, please send the DT for that board too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/35220618/attachment.sig>
