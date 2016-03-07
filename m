From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 07 Mar 2016 14:55:27 +0530
Subject: [PATCH v2] arm64: dts: Add tmu node for exynos7
In-Reply-To: <56DD0022.20800@samsung.com>
References: <1456477590-4530-1-git-send-email-alim.akhtar@samsung.com>
 <56DD0022.20800@samsung.com>
Message-ID: <56DD4907.8030100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 03/07/2016 09:44 AM, Krzysztof Kozlowski wrote:
> On 26.02.2016 18:06, Alim Akhtar wrote:
>> This patch adds tmu node, related temprature sensor and triping
>> point data for Atlas cpu core found on exynos7 SoC.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>> Changes since v1:
>> * Addressed krzysztof's review comments.
>>
>>   .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |   25 +++++++++
>>   .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   54 ++++++++++++++++++++
>>   arch/arm64/boot/dts/exynos/exynos7.dtsi            |   20 ++++++++
>>   3 files changed, 99 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
>>   create mode 100644 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
>>
>
> Looks good to me.
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
Thanks!

> I don't have anything in DTS queue for v4.6 and it is late so I'll apply
> this for v4.7 after upcoming merge window.
>
I am ok with this patch going for v4.7.

> Best regards,
> Krzysztof
>
>
>
