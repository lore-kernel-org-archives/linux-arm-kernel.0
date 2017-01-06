From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 06 Jan 2017 18:06:43 +0900
Subject: [PATCH v3 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong
 information of ldo23 and ldo25
In-Reply-To: <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035913epcas5p20336406863f1029ccf614520f366ddcf@epcas5p2.samsung.com>
 <1483675149-32598-2-git-send-email-jcsing.lee@samsung.com>
 <20170106070539.wd3kfhi77pa5ekcy@kozik-lap> <586F4554.6020206@samsung.com>
 <20170106085026.5pfwyxt2qipzbjpy@kozik-lap>
Message-ID: <73639ec8-028a-56a2-0b47-3465974ec3f3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 01? 06? 17:50, Krzysztof Kozlowski wrote:
> On Fri, Jan 06, 2017 at 04:20:52PM +0900, Chanwoo Choi wrote:
>> On 2017? 01? 06? 16:05, Krzysztof Kozlowski wrote:
>>> On Fri, Jan 06, 2017 at 12:59:05PM +0900, Jaechul Lee wrote:
>>>> From: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>> This patch fixes the wrong information of ldo23 and ldo25 on both TM2 and TM2E.
>>>
>>> Please describe what is exactly wrong and how it affects the
>>> system/user. This is going to the fixes so it needs a good explanation.
>>
>> When I posted the patch[1], I refer to the old schematic document of both TM2 and TM2E.
>> [1] 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
>>
>> After checking the highest version of schematic document of both TM2 and TM2E,
>> there is no difference of ldo23/ldo25 on both TM2 and TM2E.
>> - ldo23 is used on TM2/TM2E, but the name/max-microvolt are wrong. 
>> - ldo25 isn't used on TM2/TM2E. (not connected)
>>
>> Because ldo23 and lod25 are not used on other device in Exynos5433 and TM2 board.
>> this patch does not affect the operation to system/user.
> 
> If it does not affect anyone (including TM2/TM2E) then this do not have
> to be a fix. Am I right?

This patch does not affect the TM2/TM2E's operation
because ldo23/25 are not used on TM2/TM2E. Just fix the wrong information.

-- 
Best Regards,
Chanwoo Choi
S/W Center, Samsung Electronics
