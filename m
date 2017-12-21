From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 21 Dec 2017 20:31:48 +0100
Subject: [GIT PULL 2/3] arm64: dts: exynos: DTS for v4.16
In-Reply-To: <CAK8P3a2obLRFK8cZ3B1M1qCzDQq=-7ux4_Tu4kG+ksW6NCieYg@mail.gmail.com>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-4-krzk@kernel.org>
 <CAK8P3a2obLRFK8cZ3B1M1qCzDQq=-7ux4_Tu4kG+ksW6NCieYg@mail.gmail.com>
Message-ID: <CAJKOXPfKXWAmWUb86YW3zP3iniCU_hnZuacW4HONvYbmi0uoag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 5:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> Samsung DTS ARM64 changes for v4.16
>>
>> 1. Add CPU perf counters to Exynos5433.
>> 2. Add missing power domains to Exynos5433.
>> 3. Add NFC chip to Exynos5433 TM2/TM2E.
>> 4. Fix obscure bugs on I2C transfers to MHL chip on TM2/TM2E.
>
> Pulled into next/dt, thanks!
>
> One question: do you know if anyone is working on support for the newer
> Exynos chips, or the Nexell S5P6818 series? It seems odd that none of
> the chips from the past three years are supported yet.

For the new Exynos chips - I think Samsung folks are working on them.
Indeed it looks like the pace for new chips has slowed down.

The Nexell series are similar to Exynos but this is different company
so probably they would end up in different sub-arch. Only some IP
blocks are similar to Exynos even though the datasheet has Samsung
marks. I saw patches for U-Boot (I do not remember the author) so
maybe soon something will happen on LKML.

Best regards,
Krzysztof
