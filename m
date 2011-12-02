From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 2 Dec 2011 04:36:02 +0000
Subject: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <878vmws4z8.fsf@ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
 <878vmxxjrv.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
 <878vmws4z8.fsf@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A902847B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Dec 01, 2011 at 20:40:03, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
:
> > We can detect the board using on-board EEPROM, so same mach-id
> > should work for both EVM and Beagle. 
> 
> > And also going forward with device tree approach we may
> > not need different id's, right?
> 
> Right, which is why I'm wondering why are there sevral new AM33x
> mach-types when only one of them is being used:
> 
> 3684    TI AM335X IA EVM        am335xiaevm     Afzal Mohammed
> 3589    TI AM335X EVM           am335xevm       Vaibhav Bedia
> 3808    Beaglebone Board        beaglebone      Steven Kipisz
> 
> Russell has been trying to cleanup athe mach-types, so if these others
> are not going to be used, I suggest they be deleted.

"3684-TI AM335X IA EVM" is required as IA EVM uses a different UART,
because of which early prints can't be captured, problem mentioned
in http://marc.info/?l=linux-omap&m=131286938723617&w=2


Note: Paul advised to post to linux-arm-kernel at lists.infradead.org,
but it never made to LAKML, even though I sent couple of times and got
a reply "Is being held until the list moderator can review it for
approval. The reason it is being held: Message has a suspicious header"

Regards
Afzal
