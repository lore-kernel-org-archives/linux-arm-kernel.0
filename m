From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 29 Mar 2011 08:50:55 +0200
Subject: MACH_TYPE undeclared error
In-Reply-To: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Message-ID: <20110329065055.GA26987@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Medhavi,

On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
> undeclared here (not in a function)

See 6f82f4db80189281a8ac42f2e72396accb719b57 (ARM: Update (and cut down) 
mach-types), and the recent discussion in this list 
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/110967).

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
