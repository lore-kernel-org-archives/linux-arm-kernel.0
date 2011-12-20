From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 20 Dec 2011 12:15:01 +0000
Subject: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <87aa7akhe9.fsf@ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
 <878vmxxjrv.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
 <878vmws4z8.fsf@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A902847B@DBDE01.ent.ti.com>
 <87aa7akhe9.fsf@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8062CD4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, December 02, 2011 11:04 PM
> To: Mohammed, Afzal
> Cc: Hiremath, Vaibhav; Russell King; linux-omap at vger.kernel.org;
> tony at atomide.com; linux-arm-kernel at lists.infradead.org; paul at pwsan.com
> Subject: Re: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
> 
> "Mohammed, Afzal" <afzal@ti.com> writes:
> 
> > Hi Kevin,
> >
> > On Thu, Dec 01, 2011 at 20:40:03, Hilman, Kevin wrote:
> >> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> > :
> >> > We can detect the board using on-board EEPROM, so same mach-id
> >> > should work for both EVM and Beagle.
> >>
> >> > And also going forward with device tree approach we may
> >> > not need different id's, right?
> >>
> >> Right, which is why I'm wondering why are there sevral new AM33x
> >> mach-types when only one of them is being used:
> >>
> >> 3684    TI AM335X IA EVM        am335xiaevm     Afzal Mohammed
> >> 3589    TI AM335X EVM           am335xevm       Vaibhav Bedia
> >> 3808    Beaglebone Board        beaglebone      Steven Kipisz
> >>
> >> Russell has been trying to cleanup athe mach-types, so if these others
> >> are not going to be used, I suggest they be deleted.
> >
> > "3684-TI AM335X IA EVM" is required as IA EVM uses a different UART,
> > because of which early prints can't be captured, problem mentioned
> > in http://marc.info/?l=linux-omap&m=131286938723617&w=2
> 
> This problem will be solved by using the device tree.
> 

Kevin,

Will this solve earlyprintk as well?

Thanks,
Vaibhav

> Kevin
