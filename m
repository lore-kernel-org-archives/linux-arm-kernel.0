From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 24 Feb 2015 15:14:14 +0000
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <1542574.d99bFx24pn@wuerfel>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
 <1542574.d99bFx24pn@wuerfel>
Message-ID: <54EC9546.50005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 21/01/15 14:43, Arnd Bergmann wrote:
> On Wednesday 21 January 2015 12:02:30 Sudeep Holla wrote:
>>
>> Hi Arnd/Olof,
>>
>> Though this patch and commit 5d425c18653731af6 ("arm64: kernel: add
>> support for cpu cache information") which is in -next(via arm64) are
>> dependent to provide desired functionality, then can go indepedently
>> if you think there could be conflicts if this change is taken via arm64.
>> If not, Catalin can pick up with your acks after the review.
>
> I think it would be better to take this through arm-soc. It's not
> extremely likely to cause conflicts, but as you say there are no
> strict dependencies on which goes in first, so there is no harm
> in merging them separately.
>

I think this patch got missed for -rc1. The arm64 architectural
support patch for cacheinfo got merged via arm64 tree. It would be good
if this is also merged so that cache information can be exposed
to the user-space on ARM Ltd boards.

Regards,
Sudeep
