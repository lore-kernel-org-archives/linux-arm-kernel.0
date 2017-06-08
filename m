From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 8 Jun 2017 12:07:16 -0700
Subject: [PATCH 2/3] efi/libstub: arm64: force 'hidden' visibility for
 section markers
In-Reply-To: <20170518090953.32628-3-ard.biesheuvel@linaro.org>
References: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
 <20170518090953.32628-3-ard.biesheuvel@linaro.org>
Message-ID: <20170608190716.GF141096@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, May 18, 2017 at 10:09:52AM +0100 Ard Biesheuvel ha dit:

> To prevent the compiler from emitting absolute references to the section
> markers when running in PIC mode, override the visibility to 'hidden' for
> all contents of asm/sections.h
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
