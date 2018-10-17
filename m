From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 17 Oct 2018 10:38:20 +0200
Subject: [PATCH v5 2/9] ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
In-Reply-To: <20181017073813.14127-3-anarsoul@gmail.com>
References: <20181017073813.14127-1-anarsoul@gmail.com>
 <20181017073813.14127-3-anarsoul@gmail.com>
Message-ID: <20181017083820.bmxu7j3ctbcmzh36@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:38:06AM -0700, Vasily Khoruzhick wrote:
> BCLK / LRCK ratio should be sample size * channels, but it was
> hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
> 
> Calculate it basing on sample size and number of channels.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/17a48cd0/attachment.sig>
