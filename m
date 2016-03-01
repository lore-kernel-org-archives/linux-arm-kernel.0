From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 1 Mar 2016 17:57:26 +0900
Subject: [PATCH v3] arm64: defconfig: Enable samsung MFD and related
 configs
In-Reply-To: <56C00BBB.4080807@samsung.com>
References: <1454652269-6100-1-git-send-email-alim.akhtar@samsung.com>
 <56C00BBB.4080807@samsung.com>
Message-ID: <CAJKOXPc_U0fkHzcyJd+KBKoyYLC0GRmrKH0sgna5fYqfRp0gUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-14 14:08 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> W dniu 05.02.2016 o 15:04, Alim Akhtar pisze:
>> Exynos7 based espresso board uses S2MPS15, a multifunction device.
>> This patch enables S2MPS1X regulator, pmic-clk and rtc drivers utilized by
>> the same.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>> Changes since v2:
>> * Added Reviewed-by from Krzysztof
>> * rebased on next-20160204
>>
>> Changes since v1:
>> * updated the comment message to describe which platfrom uses it.
>> * enable COMMON_CLK_S2MPS11 which is needed to enable pmic-clk block.
>>
>>  arch/arm64/configs/defconfig |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>
> Applying this to my tree would cause conflicts with commit efdda175c07f:
> arm64: defconfig: add spmi and usb related configs
> Conflicts are trivial (simple additions) but maybe it is better to avoid
> them.
>
> Olof/Arnd/Kevin, can you apply this directly to arm-soc?

Never mind, applied because I have one more defconfig patch. The
conflict will be still there but easy to solve.

Best regards,
Krzysztof
