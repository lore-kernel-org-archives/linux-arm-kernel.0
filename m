From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 14:48:57 +0200
Subject: [PATCH 2/2] pinctrl: sunxi: number gpio ranges starting from 0
In-Reply-To: <1405358677-23657-3-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-3-git-send-email-wens@csie.org>
Message-ID: <20140724124857.GX20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 01:24:37AM +0800, Chen-Yu Tsai wrote:
> The pinctrl-sunxi driver originally used the pin number as the gpio
> range offset. This resulted in large, bogus gpio numbers for the
> new sun6i-a31-r pinctrl devices.
> 
> This patch makes the driver number the gpios ranges starting from an
> offset of 0, by subtracting the pin_base number from the pin number.
> This also makes the system-wide gpio number match the pin number.
> 
> Tested on sun8i with sysfs exported gpios.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/3c18f510/attachment.sig>
