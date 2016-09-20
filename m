From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Sep 2016 09:25:51 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.9 (#1)
In-Reply-To: <4288010.vBvIiUCvY8@wuerfel> (Arnd Bergmann's message of "Mon, 19
 Sep 2016 23:49:37 +0200")
References: <87bmzqbilu.fsf@free-electrons.com> <21718559.viYP8Vn8qc@wuerfel>
 <4288010.vBvIiUCvY8@wuerfel>
Message-ID: <87shsv6ni8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On lun., sept. 19 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday, September 19, 2016 11:46:22 PM CEST Arnd Bergmann wrote:
>> On Wednesday, September 14, 2016 5:34:37 PM CEST Gregory CLEMENT wrote:
>> > mvebu soc for 4.9 (part 1)
>> > 
>> > - irq cleanup for old mvebu SoC
>> > - Convert orion5x based SoC Netgear WNR854T to devicetree
>> > 
>> 
>> Pulled into next/soc, thanks!
>
> Sorry, backed out again after seeing the PCI stuff on the WNR854T in
> there. I thought the plan was to leave out PCI support from the DT
> based machine file, and leave the old board in place, or am I
> missing something?

I might have overlooked the thread, I thouhgt the state of the patch was
OK as is, and further changes can be done later.

So it seems that it will be 4.10 material.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
