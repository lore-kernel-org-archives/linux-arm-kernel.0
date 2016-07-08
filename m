From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 14:46:58 +0200
Subject: [PATCH] arm64: defconfig: Enable s2mps11 regulator clk and s3c rtc
 driver
In-Reply-To: <577F8E99.80301@samsung.com>
References: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
 <577C9F2C.4040509@samsung.com> <577F8E99.80301@samsung.com>
Message-ID: <577FA0C2.60501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 01:29 PM, Alim Akhtar wrote:
> 
> 
> On 07/06/2016 11:33 AM, Krzysztof Kozlowski wrote:
>> On 07/05/2016 12:06 PM, Alim Akhtar wrote:
>>> The s3c rtc controller on exynos7 platform uses rtc source clock
>>> from s2mps11 pmic. This patch enables the required bits to make
>>> rtc work on exynos7-espresso board.
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>   arch/arm64/configs/defconfig |    2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> Thanks, applied, with changed commit title and message. Any more arm64
>> defconfig changes coming soon?
>>
> Thanks Krzysztof,
> May be we should enable CONFIG_S3C2410_WATCHDOG as well.
> All the bits to enable this is there, even in exynos7 dts watchdog is
> enabled.
> Let me know if you want me to send a patch or you can add in my last
> patch related with config changes, if this is not very difficult for you
> to handle.

Probably there are few more things useful, like SPI, PWM etc. Need to
take a closer look.

Best regards,
Krzysztof
