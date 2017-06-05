From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jun 2017 15:51:28 +0200
Subject: [PATCH 0/3] pinctrl: sun8i: Add support for A83T R_PIO
In-Reply-To: <20170603144427.22855-1-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
Message-ID: <20170605135128.cjease7t25kjc6lp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 03, 2017 at 10:44:24PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> This series adds support for the R_PIO pin controller on the A83T.
> The pins managed this controller are mainly used for communicating
> with the PMIC and codec, and various GPIOs for enabling power switches
> for USB ports and WiFi.
> 
> Patch 1 updates the sunxi pinctrl bindings.
> 
> Patch 2 adds the pinctrl driver.
> 
> Patch 3 adds a device node for the pin controller.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/c617b6de/attachment.sig>
