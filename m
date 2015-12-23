From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Dec 2015 15:12:21 +0000
Subject: [PATCH] ARM: mvebu: Update the mpp63 function in the device tree
 on Armada 370
In-Reply-To: <1450881770-21189-1-git-send-email-gregory.clement@free-electrons.com>
References: <1450881770-21189-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151223151221.GM18249@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 03:42:50PM +0100, Gregory CLEMENT wrote:
> Since the commit a526973e0291 ("pinctrl: mvebu: Fix mapping of pin
> 63 (gpo -> gpio)"), the mpp63 is no more declared as a GPO but is a
> GPIO. Even if in the datasheet this pin is described as GPO, the
> experience of the D-Link DNS-327L board shows that it can be used as a
> GPIO.
> 
> This commits generated warnings for the board using this pin as gpo, with
> this patch the dts are fixed by using the new function (gpio) instead of
> the old one.
> 
> The binding documentation has also been updated accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
