From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 22:04:18 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable asm and NEON accelerated
 crypto modules
In-Reply-To: <1431338798-26909-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1431338798-26909-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <15086315.7fcREg1jQ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 12:06:38 Ard Biesheuvel wrote:
> Enable all drivers under CONFIG_ARM_CRYPTO as modules. Enable
> CONFIG_KERNEL_MODE_NEON as well so that the modules that either
> contain a NEON alternative or consist solely of a NEON (or ARMv8
> crypto extensions) accelerated implementation are enabled fully as
> well.
> 
> Note that the ARMv8 modules will only be built if the detected
> toolchain version is recent enough (binutils 2.23 or higher).
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied to next/defconfig, thanks!

	Arnd
