From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 15 Oct 2018 10:24:50 +0200
Subject: [PATCH v2 5/9] ASoC: sunxi: Add new driver for Allwinner A64
 codec's analog path controls
In-Reply-To: <20181013165329.13363-6-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-6-anarsoul@gmail.com>
Message-ID: <20181015082450.i56n5cppwgiu44ko@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 09:53:25AM -0700, Vasily Khoruzhick wrote:
> The internal codec on A64 is split into 2 parts. The analog path controls
> are routed through an embedded custom register bus accessed through
> the PRCM block.
> 
> Add an ASoC component driver for it. This should be tied to the codec
> audio card as an auxiliary device.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/25091c2c/attachment.sig>
