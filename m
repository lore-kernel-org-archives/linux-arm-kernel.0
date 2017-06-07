From: hoegeun.kwon@samsung.com (Hoegeun Kwon)
Date: Wed, 07 Jun 2017 15:14:20 +0900
Subject: [PATCH v5 4/5] arm64: dts: exynos: Remove the OF graph from DSI
 node
In-Reply-To: <9508dfc9-7cd3-3ed3-f642-2f69a5dcb5ce@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p21a483d429e2169b322e40fd833c47f27@epcas1p2.samsung.com>
 <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
 <20170515164829.rfcqj5quw2jooh6u@kozik-lap>
 <9508dfc9-7cd3-3ed3-f642-2f69a5dcb5ce@samsung.com>
Message-ID: <ac8dc366-4273-9e24-a60e-ece22a6ad5bc@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2017 03:17 PM, Hoegeun Kwon wrote:
> On 05/16/2017 01:48 AM, Krzysztof Kozlowski wrote:
>> On Wed, Mar 08, 2017 at 01:54:11PM +0900, Hoegeun Kwon wrote:
>>> The OF graph is not needed because the panel is a child of dsi. Remove
>>> the ports node in DSI node.
>>>
>>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
>>> ---
>>>   arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14 
>>> --------------
>>>   1 file changed, 14 deletions(-)
>>>
>> Hi,
>>
>> I wanted to apply this (and 5/5) but it seems that DRM change is not
>> merged. Was it included in v4.12-rc1?
>>
>> Best regards,
>> Krzysztof
>
> Hi,
>
> Sorry for my belated reply.
>
> The DRM patch(3/5) is not merged in v4.12-rc1 (mainline)...
> I have checked the David's branch, but not merged.
> However it was merged into Inki's exynos drm branch.
>
> Inki, Could you check the patch(3/5).
>
> Best regards,
> Hoegeun

Hi Krzysztof,

The drm patch(3/5) has been merged into v4.12-rc4.

Best regards,
Hoegeun
