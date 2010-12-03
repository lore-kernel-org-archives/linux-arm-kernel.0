From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 03 Dec 2010 21:46:57 +0900
Subject: [PATCH 02/10] ARM S3C2416: Add address map and clock definitions
	for HSMMC0
In-Reply-To: <20101130082152.GA19722@jeknote.loshitsa1.net>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-2-git-send-email-jekhor@gmail.com>
	<001b01cb905f$27aea180$770be480$%kim@samsung.com>
	<20101130082152.GA19722@jeknote.loshitsa1.net>
Message-ID: <015e01cb92e8$2dc1ba90$89452fb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> On Tue, Nov 30, 2010 at 04:21:01PM +0900, Kukjin Kim wrote:
> > Yauhen Kharuzhy wrote:
> > >
> > > Define maps for HSMMC devices.
> > >
> > > S3C2443 has one HSMMC device with base address 0x4A800000.
> >
> > Hmm...according to data sheet, there are two SD/MMC on S3C2443.
> > The base address of channel 0 is 0x4A800000 and channel 1 is 0x5A000000.
> > So, need to update your patch.
> 
> No. 0x5A000000 is old-style SD Interface, HSMMC is SDHCI. They are
> handled by different drivers.
> 

Hi Yauhen,

Beginning next week, I will continue to review this and your other following
patches.

- [PATCH] ARM S3C24XX: Fix compilation of PM code for S3C2416
- [PATCH v2] ARM: S3C2416: Add platform helpers for setup SDHCI

It's late here ;-)

> >
> > > S3C2416 has HSMMC0 at 0x4AC00000 and HSMMC1 at 0x4A800000.
> > >
> > > So suppose that S3C2443 has only HSMMC1.
> > >
> > Hmm...
> >
> > > Define clock for hsmmc0 device and register it.
> > >
> > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
