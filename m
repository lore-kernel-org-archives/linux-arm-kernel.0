From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 20 Nov 2014 10:55:31 +0900
Subject: exynos boot falures in linux-next
In-Reply-To: <546CCE2F.8030108@collabora.co.uk>
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7hoas54y7k.fsf@deeprootsystems.com> <7hlhn9zcse.fsf@deeprootsystems.com>
 <546A83D6.9060504@collabora.co.uk> <7hfvdhyxqi.fsf@deeprootsystems.com>
 <CAMAWPa8D-oRp2yC=n+Rgw_wtwV4+Go0OQi62y3iGRYxi0sow+g@mail.gmail.com>
 <546CCE2F.8030108@collabora.co.uk>
Message-ID: <00ae01d00465$10d9edb0$328dc910$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:

+ Olof,

> Hello Kevin,
> 
Hi,

> On 11/19/2014 06:01 PM, Kevin Hilman wrote:
>>>>
>>>> I'm not sure what is the correct step in this case but I'm OK with
>>>> reverting the patch until the Exynos DRM driver bug is fixed.
>>>
>>> I didn't have time to dig, but I'd rather someone track down the DRM
>>> problem and fix that, since it was known to be working. I'm guessing
>>> it's something simple that can be fixed before the merge window opens.
>> 
>> OK, so this DRM problem is turning out to be non-trivial, so I think
>> the defconfig patch should be reverted until the DRM issue is sorted
>> out.
>> 
>> Otherwise, we risk having boot failures in linux-next which may be
>> hiding other problems.
>> 
>> Kevin
>> 
> 
> Agreed with the config revert, so many issues with Exynos DRM in
linux-next :(
>
Yeah, it could be a best solution at this moment. Let me revert the commit
0ef76aea7a34 ("ARM: exynos_defconfig: Enable options for display panel
support")
from -next in samsung tree.

Thanks,
Kukjin
