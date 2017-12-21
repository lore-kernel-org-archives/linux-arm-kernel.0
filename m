From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 17:50:52 +0100
Subject: [GIT PULL 2/3] arm64: dts: exynos: DTS for v4.16
In-Reply-To: <20171220173643.5840-4-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-4-krzk@kernel.org>
Message-ID: <CAK8P3a2obLRFK8cZ3B1M1qCzDQq=-7ux4_Tu4kG+ksW6NCieYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung DTS ARM64 changes for v4.16
>
> 1. Add CPU perf counters to Exynos5433.
> 2. Add missing power domains to Exynos5433.
> 3. Add NFC chip to Exynos5433 TM2/TM2E.
> 4. Fix obscure bugs on I2C transfers to MHL chip on TM2/TM2E.

Pulled into next/dt, thanks!

One question: do you know if anyone is working on support for the newer
Exynos chips, or the Nexell S5P6818 series? It seems odd that none of
the chips from the past three years are supported yet.

     Arnd
