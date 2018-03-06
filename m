From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2018 17:16:45 +0100
Subject: [PATCH 1/2] arm64: defconfig: add newly added accelerated crypto
 modules
In-Reply-To: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
References: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
Message-ID: <CAK8P3a37ZiZeYJE_i0nkA2__YmHmrmqbVeHvWwDB5gwuWSckoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 10:26 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> New crypto drivers have been introduced in v4.16 that implement the
> SHA-512, SHA3 and SM3 secure hash algorithms using ARMv8.2 optional
> instructions. Add these drivers to arm64's defconfig as modules.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

Applied to next/soc, thanks!

      Arnd
