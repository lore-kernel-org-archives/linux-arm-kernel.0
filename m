From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 15 Oct 2016 09:56:59 +0200 (CEST)
Subject: [PATCH 3/4] ARM: bcm2835: Add #define for VCHIQ property message.
In-Reply-To: <487621239.358635.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
References: <20161003185209.27733-1-eric@anholt.net>
 <20161003185209.27733-4-eric@anholt.net>
 <487621239.358635.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
Message-ID: <1031961583.358662.2bd73c71-f221-4323-833d-b752e7c41a53.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 15. Oktober 2016 um 09:53
> geschrieben:
> 
> 
> Hi Greg,
> 
> > Eric Anholt <eric@anholt.net> hat am 3. Oktober 2016 um 20:52 geschrieben:
> > 
> > 
> > This comes from the downstream tree and is needed for the new VCHIQ
> > driver in staging.
> 
> maybe it's not clear from the commit message, but RPI_FIRMWARE_VCHIQ_INIT is
> already used in
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> 
> So this patch fixes also a build issue.
> 

Sorry about the noise. You already applied it.
