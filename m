From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Sep 2016 18:43:34 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.9 (#1)
In-Reply-To: <5238448.m4YaC7vVme@wuerfel> (Arnd Bergmann's message of "Tue, 20
 Sep 2016 11:45:50 +0200")
References: <87bmzqbilu.fsf@free-electrons.com> <4288010.vBvIiUCvY8@wuerfel>
 <87shsv6ni8.fsf@free-electrons.com> <5238448.m4YaC7vVme@wuerfel>
Message-ID: <87eg4e5xop.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., sept. 20 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, September 20, 2016 9:25:51 AM CEST Gregory CLEMENT wrote:
>> Hi Arnd,
>>  
>>  On lun., sept. 19 2016, Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>> > On Monday, September 19, 2016 11:46:22 PM CEST Arnd Bergmann wrote:
>> >> On Wednesday, September 14, 2016 5:34:37 PM CEST Gregory CLEMENT wrote:
>> >> > mvebu soc for 4.9 (part 1)
>> >> > 
>> >> > - irq cleanup for old mvebu SoC
>> >> > - Convert orion5x based SoC Netgear WNR854T to devicetree
>> >> > 
>> >> 
>> >> Pulled into next/soc, thanks!
>> >
>> > Sorry, backed out again after seeing the PCI stuff on the WNR854T in
>> > there. I thought the plan was to leave out PCI support from the DT
>> > based machine file, and leave the old board in place, or am I
>> > missing something?
>> 
>> I might have overlooked the thread, I thouhgt the state of the patch was
>> OK as is, and further changes can be done later.
>> 
>> So it seems that it will be 4.10 material.
>> 
>
> We have gained a little more time since Linus delayed the merge window
> by another week, so I think there is still a chance to respin this.
>
> I also really want the NO_IRQ changes to get merged ;-)
>
> Just drop the patch removing wnr854t-setup.c, and add another patch
> on top to remove the PCI initialization from wrt350n-v2-setup.c,
> and I'll take it.

Do you mean board-wnr854t.c?

If it is the case then I can just drop the patch adding this file because
the only things done in this file are about the PCI.

Gregory

>
> 	Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
