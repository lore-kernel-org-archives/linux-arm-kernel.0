From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 17 Nov 2014 19:49:09 -0800
Subject: exynos boot falures in linux-next
In-Reply-To: <546A83D6.9060504@collabora.co.uk> (Javier Martinez Canillas's
 message of "Tue, 18 Nov 2014 00:25:10 +0100")
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7hoas54y7k.fsf@deeprootsystems.com>
 <7hlhn9zcse.fsf@deeprootsystems.com>
 <546A83D6.9060504@collabora.co.uk>
Message-ID: <7hfvdhyxqi.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

> Hello Kevin,
>
> On 11/17/2014 11:24 PM, Kevin Hilman wrote:
>> 
>> As might have been expected, reverting the change that enables the
>> DRM/display options in exynos_defconfig fixes the problem.
>> 
>> Kevin
>>
>
> I'm sorry for causing a boot failure but when I first posted that patch,
> the Exynos DRM driver was working correctly (at least on the Exynos boards
> I've access to) 

Yeah, I tested it at the time as well, so I know it was working.

> so it seems the regression was introduced while the patch
> was posted but not yet picked.
>
> I'm not sure what is the correct step in this case but I'm OK with
> reverting the patch until the Exynos DRM driver bug is fixed.

I didn't have time to dig, but I'd rather someone track down the DRM
problem and fix that, since it was known to be working. I'm guessing
it's something simple that can be fixed before the merge window opens.

Kevin
