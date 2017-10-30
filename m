From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 30 Oct 2017 10:38:38 +0100
Subject: [PATCH v2] ARM: dts: exynos: add cpu perf counters to Exynos54xx
 boards
In-Reply-To: <CAM3PiRwqS21a-z6L0yqM0stUSnbKY9pdWKGJfpnyePQ3AZJqdw@mail.gmail.com>
References: <1508812196-14478-1-git-send-email-mihailescu2m@gmail.com>
 <CAM3PiRwqS21a-z6L0yqM0stUSnbKY9pdWKGJfpnyePQ3AZJqdw@mail.gmail.com>
Message-ID: <CAJKOXPekn5JUmjcmcqT6HHQUbd7yCGC9mA-oPcEMRjTL0OvQ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 10:34 AM, Marian Mihailescu
<mihailescu2m@gmail.com> wrote:
> Hi,
>
> Can I get feedback on this last patch?

Just six days passed... I'll take a look soon, it is not lost. But
anyway merge window is too close so I am not planning to take anything
more for upcoming release.

Best regards.
Krzysztof


>
> Thanks,
> Marian
> Either I've been missing something or nothing has been going on. (K. E. Gordon)
>
>
> On Tue, Oct 24, 2017 at 12:59 PM, memeka <mihailescu2m@gmail.com> wrote:
>> Enable support for ARM Performance Monitoring Units available in Cortex-A7
>> and Cortex-A15 CPU cores for Exynos54xx SoCs (5410, 5420 and 5422/5800).
>>
>> The PMUs interrupts are defined in the common exynos54xx.dtsi device tree,
>> but the PMUs are enabled and have their interrupt CPU affinity defined
>> next to each SoC's cpus node.
>>
>> Tested with perf on Odroid XU4 (Exynos5422):
>> armv7_cortex_a7 PMU driver: 5 counters available
>> armv7_cortex_a15 PMU driver: 7 counters available
>>
>> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
>> Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
>>
