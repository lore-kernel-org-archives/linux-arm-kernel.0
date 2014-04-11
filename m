From: cwchoi00@gmail.com (=?UTF-8?B?7LWc7LCs7Jqw?=)
Date: Sat, 12 Apr 2014 07:30:46 +0900
Subject: [PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent
 connected with GIC
In-Reply-To: <5347AD19.7080905@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397124377-16969-4-git-send-email-cw00.choi@samsung.com>
 <20140411040050.GD14934@quad.lixom.net>
 <53477347.1080603@samsung.com> <5347AD19.7080905@samsung.com>
Message-ID: <CAGTfZH2DEWjLi=d0_U0mHYACY+_EUTt4Y3GyOvzVYb7HQk62mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Fri, Apr 11, 2014 at 5:51 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Chanwoo,
>
>
> On 11.04.2014 06:44, Chanwoo Choi wrote:
>>
>> Hi,
>>
>> On 04/11/2014 01:00 PM, Olof Johansson wrote:
>>>
>>> On Thu, Apr 10, 2014 at 07:06:02PM +0900, Chanwoo Choi wrote:
>>>>
>>>> This patch add interrupt-parent node to connected with GIC.
>>>> All interrupt-related dt nodes need default interrupt-parent node.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>
>>>
>>> There's no point in splitting these off in separate patches; fold them
>>> into one patch that introduces the SoC dtsi, please.
>>
>>
>> OK, I will consolidate following two patches into one patch.
>>
>> [PATCH 11/27] ARM: dts: exynos3250: Add GIC dt node for Exynos3250
>> [PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent connected
>> with GIC
>>
>
> I believe the intention was to squash all the patches related to
> exynos3250.dtsi into a single patch called "ARM: dts: Add device tree
> sources for Exynos3250". To retain authorship information, signed-off-by
> tags should be merged from all those patches too.
>

As you comment, I will consolidate exynos3250.dtsi into only one patch
on next posting(v2).
Thanks,

Best Regards,
Chanwoo Choi
