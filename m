From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 21 Aug 2013 11:51:53 +0100
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a
 regular filesystem on SD card
In-Reply-To: <1377075956.3591.23.camel@linaro1.home>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
 <1377075956.3591.23.camel@linaro1.home>
Message-ID: <1377082313.10707.11.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-21 at 10:05 +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2013-08-21 at 00:02 +0300, Fathi Boudra wrote:
> > vexpress_defconfig is known broken on some use-cases. This serie of
> > patches allow to boot test Versatile Express using a regular filesystem
> > on SD card.
> > 
> > Fathi Boudra (3):
> >   ARM: vexpress_defconfig: Enable and automount devtmpfs filesystem
> >   ARM: vexpress_defconfig: Enable voltage regulator support
> >   ARM: vexpress_defconfig: Enable ext4 filesystem
> > 
> >  arch/arm/configs/vexpress_defconfig | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> One good question is who do you have to convince to get these changes
> accepted (or rejected)?

This gets down to the question do we actually want the
vexpress_defconfig at all? I was considering removing it completely as
multi_v7_defconfig should do the job (potentially subject to an extra
config option or two), but if there really is a need for vexpress-only
one, I can take the changes and queue it for the next-next merge window.

Pawe?
