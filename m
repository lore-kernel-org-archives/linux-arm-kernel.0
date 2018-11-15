From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 15 Nov 2018 23:41:46 +0100 (CET)
Subject: [PATCH] ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2
 camera driver
In-Reply-To: <8736s3xmrc.fsf@anholt.net>
References: <1542229864-27695-1-git-send-email-stefan.wahren@i2se.com>
 <8736s3xmrc.fsf@anholt.net>
Message-ID: <957710337.11499.1542321706456@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Eric Anholt <eric@anholt.net> hat am 15. November 2018 um 00:28 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > This enables the bcm2835-camera driver, which depends on bcm2835-vchiq.
> > After that we gain more test coverage (e.g. Kernel CI).
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >  arch/arm/configs/bcm2835_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > Hi, i will submit a patch series to address those probing issues. But this is
> > independent from this patch.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-defconfig-next
