From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 15 Oct 2018 10:18:36 +0200
Subject: [PATCH v2 1/9] ASoC: sun4i-i2s: Add compatibility with A64 codec
 I2S
In-Reply-To: <20181013165329.13363-2-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-2-anarsoul@gmail.com>
Message-ID: <20181015081836.onjczcsg5qwp6rbt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 09:53:21AM -0700, Vasily Khoruzhick wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The I2S block used for the audio codec in the A64 differs from other 3
> I2S modules in A64 and isn't compatible with H3. But it is very similar
> to what is found in A10(sun4i). However, its TX FIFO is
> located at a different address.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/6cdbe2ca/attachment.sig>
