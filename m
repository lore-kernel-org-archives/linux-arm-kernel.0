From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 18:05:31 +0200
Subject: [PATCH] arm64: defconfig: add recently added crypto drivers as
 modules
In-Reply-To: <20170716195152.11285-1-ard.biesheuvel@linaro.org>
References: <20170716195152.11285-1-ard.biesheuvel@linaro.org>
Message-ID: <CAK8P3a2NRFLM38za5KCR_WD5EFRqBqsU56SyAJzrxGmOGv6vvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 16, 2017 at 9:51 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Add the arm64 crypto drivers that have been added over the past
> couple of kernel releases to its defconfig as modules.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to next/arm64, thanks!

     Arnd
