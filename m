From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 04 May 2011 09:32:20 +0300
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <BANLkTimzZr0vfOdNwVev2A_xoU_1k+SB_w@mail.gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>	<20110503205056.GA13075@gentoodev.compulab.local>	<BANLkTimQM_J2ZbDjAewUsp+XSEP+x+eniA@mail.gmail.com>	<BANLkTinybLSF418PsocXR6dwuaksv_+UCQ@mail.gmail.com>
	<BANLkTimzZr0vfOdNwVev2A_xoU_1k+SB_w@mail.gmail.com>
Message-ID: <4DC0F2F4.6000404@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/11 06:00, Hirundo Cam wrote:
> Hi Mike and Simon
> 
> 2011/5/4 Hirundo Cam <camhirundo@gmail.com>:
>> Hi Mike and Simon,
>>
>> I've send a machine submit to arm-linux, it generated the mach-types as
>>
>> [stripped]
>> mx51_moray              MACH_MX51_MORAY         MX51_MORAY              3484
>> thales_cbc              MACH_THALES_CBC         THALES_CBC              3485
>> bluepoint               MACH_BLUEPOINT          BLUEPOINT               3486
>> dir665                  MACH_DIR665             DIR665                  3487
>>
>> Is this correct for the DIR665 board using mv88f6281 chips?
> 
> Is this implied that I could get rid of the modification to mach-type
> in my patch?

Yes, as soon as mach-types update is pushed into the kernel.

> Thanks!


-- 
Sincerely yours,
Mike.
