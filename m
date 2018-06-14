From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 14 Jun 2018 09:26:24 +0200
Subject: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
In-Reply-To: <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
Message-ID: <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-06-13 at 23:52 +0200, Giulio Benetti wrote:
> Hello,
> 
> sorry for my ignorance.
> I don't know the right patch workflow in the case of "revert commit".
> When I fix this bug, should I have to re-submit the previous patch 
> entire plus bug-fix?
>
> Or do I have to submit patch with bug-fix only?

Yes, that is usually how it works! The revert patch will be picked up by
the maintainer (Maxime), integrated in his tree and eventually merged
into Linus' tree (along with stable trees).

Fixup patches for this will need to take into account the revert patch,
so it becomes equivalent to submitting the same patch with that issue
resolved.

> Thanks in advance to everybody

Cheers !

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/539bddbd/attachment.sig>
