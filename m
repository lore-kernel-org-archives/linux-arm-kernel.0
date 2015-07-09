From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jul 2015 10:04:14 +0200
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <f22e65faa7d86074cda27973f83d7a52@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel> <f22e65faa7d86074cda27973f83d7a52@advem.lv>
Message-ID: <1781580.JRD7b0UrJA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 July 2015 01:29:39 Roman Yeryomin wrote:
> 
> OK, here are the minimal changes required (see attachment). Tested on 
> 4.1.1
> Let me know if you want me to submit it in some other way.
> 

The changes look ok to me. Please submit them as two separate
patches (1. set up and use timer3, 2. register sched_clock) according
to the Documentation/SubmittingPatches description.

Thanks,

	Arnd
