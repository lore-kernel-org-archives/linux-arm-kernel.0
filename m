From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2018 17:17:10 +0100
Subject: [PATCH 2/2] arm64: defconfig: add support for Socionext SynQuacer
 based platforms
In-Reply-To: <20180214092637.14047-2-ard.biesheuvel@linaro.org>
References: <20180214092637.14047-1-ard.biesheuvel@linaro.org>
 <20180214092637.14047-2-ard.biesheuvel@linaro.org>
Message-ID: <CAK8P3a2LjiQr1XxxpLAT+81agiumSSJYX_pQH5tEbz7zKX4uPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 10:26 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Enable support in arm64's defconfig for Socionext SynQuacer based
> platforms, by enabling the arch Kconfig symbol, and enabling builtin
> support for the ethernet, GPIO and SDHCI controllers
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied to next/soc, thanks!

      Arnd
