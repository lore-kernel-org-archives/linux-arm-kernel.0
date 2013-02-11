From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Sun, 10 Feb 2013 16:38:52 -0800
Subject: [PATCH 2/5] ARM: dts: exynos5250-arndale: Add PMIC node entry
In-Reply-To: <51134218.9020603@linaro.org>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
 <1360214129-4096-2-git-send-email-tushar.behera@linaro.org>
 <F3DBB1B3EF102E4994C89758CFCA32412C4DE1@DBDE01.ent.ti.com>
 <51134218.9020603@linaro.org>
Message-ID: <CADGdYn4LOSc7oa2nMekV+uFpuBTpZu4WaNhfgErmsOgrS2GgJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V2 of this patch is posted with comments suggested by Anil and
some missing LDO's.

Thanks,
Amit Daniel

On Wed, Feb 6, 2013 at 9:56 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> On 02/07/2013 11:19 AM, Kumar, Anil wrote:
>> On Thu, Feb 07, 2013 at 10:45:26, Tushar Behera wrote:
>>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>
>>> Added S5M8767 PMIC DT nodes to Arndale board.
>>>
>>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/exynos5250-arndale.dts |  213 +++++++++++++++++++++++++++++-
>>>  1 files changed, 212 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
>>> index 9ce40df..b40a02f 100644
>>> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
>>> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
>>> @@ -25,7 +25,218 @@
>>>      };
>>>
>>>      i2c at 12C60000 {
>>> -            status = "disabled";
>>> +            status = "okay";
>>
>> Is there any need to change status "okay" here as in dtsi file it is
>> by default okay ?
>>
>
> Right, there is no need for setting it as "okay" explicitly.
>
> --
> Tushar Behera
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
