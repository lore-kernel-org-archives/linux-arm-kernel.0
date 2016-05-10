From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 May 2016 08:51:30 -0400
Subject: [PATCH v2 20/22] ARM: dts: exynos: Move common
 Exynos5410/542x/5800 nodes to new DTSI
In-Reply-To: <57317292.2080004@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
 <1462734367-5619-21-git-send-email-krzk@kernel.org>
 <9e642e0d-87e1-4661-0233-acecf0082f24@osg.samsung.com>
 <57317292.2080004@kernel.org>
Message-ID: <68ebff12-702d-106a-7ce7-5063f62f3bc1@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/10/2016 01:33 AM, Krzysztof Kozlowski wrote:
> On 05/09/2016 11:53 PM, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 05/08/2016 03:06 PM, Krzysztof Kozlowski wrote:
>>> The Exynos5410/542x/5800 are very similar designs. Create new new
>>
>> s/new new/a new
>>
>>> DTSI with common nodes to remove DTS duplication. Although currently
>>> only MCT and SysRAM are shared but in future more nodes will be added to
>>> common file.
>>>
>>> The patch should not have functional impact.
>>>
>>
>> A nice way to check this is to diff the disassembled compiled DTBs with
>> and without the patch and making sure that the resulted DTS is the same.
> 
> Yes, that is what I've done. Recently there is a tool making that even
> easier: dtx_diff.
>

I didn't know we had such a tool in mainline now.
Very useful, thanks a lot for the information.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
