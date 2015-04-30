From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Apr 2015 17:23:05 +0200
Subject: [PATCH 1/1] Revert "ARM: dts: add display power domain for
 exynos5250"
In-Reply-To: <7hk2wtpsqq.fsf@deeprootsystems.com>
References: <1427107800-21668-1-git-send-email-javier.martinez@collabora.co.uk>	<7hr3r2suiw.fsf@deeprootsystems.com>	<1430336716.19504.92.camel@collabora.co.uk>	<55417967.80304@collabora.co.uk>
 <7hk2wtpsqq.fsf@deeprootsystems.com>
Message-ID: <554248D9.4030203@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On 04/30/2015 04:59 PM, Kevin Hilman wrote:
> Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:
>>
>> The regression on Exynos5420/5422/5800 that has been for a while is fixed
>> by "ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420" [0]
>> which has been posted many weeks ago.
> 
> Thanks for clarifying.
> 
> I'm not sure how this worked for me.  Seems like sometimes, even with
> the imprecise aborts it does actually finish booting to a shell, so I
> must've gotten successful boot and thought it was because of this
> revert.

That is correct, the imprecise external abort error most of the times
lead to a kernel panic but sometimes it doesn't and the the system finish
booting to user-space even after the error.

I've pinged Kukjin again yesterday to pick the fix and he said that will
do it this weekend [0]. So hopefully exynos5420 machines will boot again
in linux-next soon after being broken for weeks.

> 
> Kevin
>

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/4/29/781
