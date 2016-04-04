From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Mon, 4 Apr 2016 13:09:24 +0200
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160330191208.GW9329@atomide.com>
References: <20160130200244.GA30429@amd> <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd> <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd> <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd> <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd> <20160330191208.GW9329@atomide.com>
Message-ID: <20160404110924.GS8413@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2016 12:12:09 Tony Lindgren wrote:
> > How idle system do I need to have? Screen is blanked and machine
> > should be mostly idle, but there's X running on another vt with Mate
> > desktop, and some python scripts... GSM modem should be online.
> 
> Well I think it's the USB only you have blocking deeper idle states.
> 
> Are you sure you rmmod:ed all the USB related modules like in my
> test script?
> 
> MUSB currently has an unresolved issue where it blocks idle states
> if loaded.

Is somebody working on this musb issue? Is there any progress?

-- 
Pali Roh?r
pali.rohar at gmail.com
