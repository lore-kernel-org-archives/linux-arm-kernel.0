From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 17:09:05 -0700
Subject: [PATCH v2] MAINTAINERS: ARM64: EXYNOS: Extend entry for ARM64 DTS
In-Reply-To: <557A1B31.1090201@samsung.com>
References: <1433584939-3520-1-git-send-email-k.kozlowski@samsung.com>
 <CAMAWPa-3RhXgCjXcdQkPn3W1SJ++iAkfaBdp_p4Se9Ykg1A1mw@mail.gmail.com>
 <557A1B31.1090201@samsung.com>
Message-ID: <CAMAWPa_R6pKHBz8fZ+FhEXcvDxwGFC9oS=N8tNnJdJkKFFePSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 4:35 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> W dniu 12.06.2015 o 06:48, Kevin Hilman pisze:
>> Hi Krzysztof,
>>
>> On Sat, Jun 6, 2015 at 3:02 AM, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> Extend the Exynos entry to ARM64 device tree sources.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Kevin Hilman <khilman@kernel.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: linux-samsung-soc at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>> Applied to arm-soc's next/soc branch.
>>
>> Note I found this by chance.  It almost fell through the cracks
>> because arm at kernel.org (for arm-soc maintainers) wasn't on the to/cc
>> list.
>
> Thanks. I was not aware of this email/list address. It isn't mentioned
> in MAINTAINERS.

Yes, that's kind of by design as it's not meant for general patch
review/discussion.

> So I suspect that any stuff intended to go directly to
> arm-soc maintainers (not through vendor SoC tree) should be sent there?

Yes, this list is specifically for subarch/platform maintainers (which
now includes you :) to send stuff that would like to be applied to the
arm-soc tree.

Thanks,

Kevin
