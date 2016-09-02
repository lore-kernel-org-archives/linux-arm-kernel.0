From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 17:38:46 +0200
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Build Atmel maXTouch
 driver as a module
In-Reply-To: <1471360094-27637-1-git-send-email-javier@osg.samsung.com>
References: <1471360094-27637-1-git-send-email-javier@osg.samsung.com>
Message-ID: <7304023.0tarkq2cRD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 16, 2016 11:08:14 AM CEST Javier Martinez Canillas wrote:
> The driver is for a trackpad device so is not needed for booting and
> makes more sense to have it as module to reduce the kernel image size.
> 
> It was probably enabled as built-in because module autoload was not
> working when the I2C device was registered by OF but this got fixed
> in commit b7d21058b40b ("Input: atmel_mxt_ts - add maxtouch to I2C
> table for module autoload") so it's safe to enable as a module now.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---

Applied to next/defconfig.

My preferred way is to get defconfig updates forwarded by the platform
maintainers that are interested, but this seems to apply to multiple
platforms, so I'm not asking you to pick one to resend it to.

	Arnd
