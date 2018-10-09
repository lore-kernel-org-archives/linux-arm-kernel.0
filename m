From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 9 Oct 2018 17:10:19 +0200
Subject: [PATCH] arm64: dts: allwinner: add backlight regulator for
 Pinebook
In-Reply-To: <20181009034609.24892-1-anarsoul@gmail.com>
References: <20181009034609.24892-1-anarsoul@gmail.com>
Message-ID: <20181009151019.b6eb6o664twnts7g@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 08:46:09PM -0700, Vasily Khoruzhick wrote:
> Backlight power is controlled by PH6 GPIO, so add corresponding
> regulator-fixed node for it. Otherwise backlight won't light up
> if bootloader doesn't enable it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Queued for 4.21, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181009/ad92b0c2/attachment.sig>
