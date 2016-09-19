From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 17:17:04 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_EFI
In-Reply-To: <1473949700-12814-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1473949700-12814-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <2505826.geSHosrjfj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 3:28:20 PM CEST Ard Biesheuvel wrote:
> This enables CONFIG_EFI for multi_v7_defconfig, which adds support for
> booting via EFI, and for the EFI framebuffer as builtin options. It
> also enables the EFI rtc, the EFI variable pseudo-filesystem and the
> EFI capsule loader as modules.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> We have been happily booting multi_v7_defconfig+CONFIG_EFI=y kernels on
> kernelci for months now, so please consider enabling this by default.
> The increase in compressed kernel footprint is ~30 KB, for the uncompressed
> kernel it's ~10 KB, some of which is .init code.
> 

Applied to next/defconfig, thanks!

	Arnd
