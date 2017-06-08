From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 8 Jun 2017 12:06:43 -0700
Subject: [PATCH 1/3] efi/libstub: arm64: use hidden attribute for struct
 screen_info reference
In-Reply-To: <20170518090953.32628-2-ard.biesheuvel@linaro.org>
References: <20170518090953.32628-1-ard.biesheuvel@linaro.org>
 <20170518090953.32628-2-ard.biesheuvel@linaro.org>
Message-ID: <20170608190643.GE141096@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, May 18, 2017 at 10:09:51AM +0100 Ard Biesheuvel ha dit:

> To prevent the compiler from emitting absolute references to screen_info
> when building position independent code, redeclare the symbol with hidden
> visibility.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
