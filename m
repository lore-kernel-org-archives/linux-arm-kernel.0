From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 15 Jun 2018 22:54:57 +0200
Subject: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
In-Reply-To: <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
 <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
Message-ID: <94a68af2-371f-d81e-b25d-31ae7869e98e@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Il 14/06/2018 09:26, Paul Kocialkowski ha scritto:
> Hi,
> 
> On Wed, 2018-06-13 at 23:52 +0200, Giulio Benetti wrote:
>> Hello,
>>
>> sorry for my ignorance.
>> I don't know the right patch workflow in the case of "revert commit".
>> When I fix this bug, should I have to re-submit the previous patch
>> entire plus bug-fix?
>>
>> Or do I have to submit patch with bug-fix only?
> 
> Yes, that is usually how it works! The revert patch will be picked up by
> the maintainer (Maxime), integrated in his tree and eventually merged
> into Linus' tree (along with stable trees).
> 
> Fixup patches for this will need to take into account the revert patch,
> so it becomes equivalent to submitting the same patch with that issue
> resolved.

Thanks for explaining me.
I'm going to submit new patch asap.

Giulio
