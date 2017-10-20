From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 20 Oct 2017 14:21:02 +0200
Subject: [PATCH] ARM: dts: exynos: add cpu perf counters to Exynos54xx
 boards
In-Reply-To: <CAM3PiRxi8sxf6T990K8rd7UsOLd2D5TaLciF=c_wF=9gmpLKYg@mail.gmail.com>
References: <CAM3PiRxi8sxf6T990K8rd7UsOLd2D5TaLciF=c_wF=9gmpLKYg@mail.gmail.com>
Message-ID: <CAJKOXPdZAzQr0QYFn5jGMBGgkC1XL-RUr5QbhBaoqMceDwA4aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 2:09 PM, Marian Mihailescu
<mihailescu2m@gmail.com> wrote:
> Hi,
>
> This patch enables support for ARM Performance Monitoring Units
> available in Cortex-A7
> and Cortex-A15 CPU cores for Exynos54xx SoCs (5410, 5420 and 5422/5800).
>
> Exynos5410 currently has only Cortex-A7 nodes defined in the device tree,
> so the Cortex-A15 PMU is defined in the exynos5420 device tree file.
>
> Tested with perf on Odroid XU4 (Exynos5422):
> armv7_cortex_a7 PMU driver: 5 counters available
> armv7_cortex_a15 PMU driver: 7 counters available

Please send this as simple text mail, not a multi-part message with
attachments. I cannot comment inline for multi-part, not mentioning
that patch is not being displayed at all. Probably this is also the
reason why patch is not present in patchwork
(https://patchwork.kernel.org/project/linux-samsung-soc/list/).

The easiest is to just run "git format-patch -1" and then "git
send-email --to .. --cc .. 0001-*".

Best regards,
Krzysztof
