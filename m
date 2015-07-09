From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Thu, 9 Jul 2015 13:58:02 +0200 (CEST)
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <1781580.JRD7b0UrJA@wuerfel>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
 <1781580.JRD7b0UrJA@wuerfel>
Message-ID: <alpine.LNX.2.00.1507091343150.24357@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 9 Jul 2015, Arnd Bergmann wrote:

> On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> > 
> > OK, here are the minimal changes required (see attachment). Tested on 
> > 4.1.1
> > Let me know if you want me to submit it in some other way.
> > 
> 
> The changes look ok to me. Please submit them as two separate
> patches (1. set up and use timer3, 2. register sched_clock) according
> to the Documentation/SubmittingPatches description.
> 
> Thanks,
> 
> 	Arnd
> 

have you seen this thread ...
[PATCH 00/18] ARM: Migrate clockevent drivers to 'set-state
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/423992

arch/arm/mach-gemini/time.c              | 69 ++++++++++++------------ 

Two or more weeks ago I send a patchset fixing this problem.
At this time Arnd was in holiday and until today I was very busy at work.

I can rework my patches on top of Viresh's patchset

and Roman please fix the subject.

Ulli
