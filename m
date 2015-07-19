From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 19 Jul 2015 18:28:17 +0200 (CEST)
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <89dc8e097d12d9400217a237b7a6ca6e@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
 <1781580.JRD7b0UrJA@wuerfel> <89dc8e097d12d9400217a237b7a6ca6e@advem.lv>
Message-ID: <alpine.LNX.2.00.1507191821310.12665@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 9 Jul 2015, Roman Yeryomin wrote:

> On 2015-07-09 11:04, Arnd Bergmann wrote:
> > On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> > > 
> > > OK, here are the minimal changes required (see attachment). Tested on
> > > 4.1.1
> > > Let me know if you want me to submit it in some other way.
> > > 
> > 
> > The changes look ok to me. Please submit them as two separate
> > patches (1. set up and use timer3, 2. register sched_clock) according
> > to the Documentation/SubmittingPatches description.
> > 
> 
> So what do we do?
> Do you still want me to split this as you said and submit or you want Hans's
> patches rebased/resubmitted?
> 
> Regards,
> Roman
> 

can you rebase your patches againt my branch at

git://github.com/ulli-kroll/linux.git gemini/clockevents/4.3

I've added here the clockevents changes for 4.3 and patch fory
arch/arm/mach-gemini 
This changes will then go arm at kernel.org.

Hans Ulli
