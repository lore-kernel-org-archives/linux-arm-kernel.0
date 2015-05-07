From: roman@advem.lv (Roman Yeryomin)
Date: Fri, 08 May 2015 00:35:20 +0300
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <alpine.LNX.2.00.1505071936170.19877@T520.local>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2694895.MomHLoCaoZ@wuerfel>
 <alpine.LNX.2.00.1505070455130.32495@T520.local>
 <5043733.xO9lSCKvly@wuerfel>
 <alpine.LNX.2.00.1505071936170.19877@T520.local>
Message-ID: <beaeec189608d669a47cac8ad589ee25@advem.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-07 20:46, Hans Ulli Kroll wrote:
> Hi
> 
> On Thu, 7 May 2015, Arnd Bergmann wrote:
> 
>> On Thursday 07 May 2015 05:00:03 Hans Ulli Kroll wrote:
>> > On Wed, 6 May 2015, Arnd Bergmann wrote:
>> > > As far as I'm concerned, we should just merge all the patches from
>> > > http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
>> > >
>> > > We should also try to find a maintainer that can respond to patches
>> > > in a timely manner. If Ulli has time for that again, that would be great,
>> > > otherwise I think we should find someone from OpenWRT to take over.
>> >
>> > I'm back in busyness.
>> > Currently me dev device is right next to me.
>> > I moved some time ago and haav to find it in some 'hidden' box.
>> 
>> Awesome, welcome back!
>> 
>> Are you able to look at the patches I mentioned above and submit them
>> to arm at kernel.org, cc linux-arm-kernel at lists.infradead.org with proper
>> patch descriptions?
>> 
>> 	Arnd
>> 
> 
> Already done,
> RTC driver send.
> Compilder fix for MACH-RECORD send.
> Maintainer Update send.
> 
> This device is a (very) bad design, to be polite !
> I think they didn't test this properly.
> And they fixed some software issues in hardware.
> To be exact :
> They switched the IDE channels in hardware, to get around the stupid
> Sausalito software.

AFAIK, ide channels are switchable in the driver.

Regards,
Roman
