From: pavel@denx.de (Pavel Machek)
Date: Sun, 17 Mar 2013 19:13:43 +0100
Subject: [PATCHv1 0/2] ARM: socfpga: Soft reset, hotplug and device
 tree clocks
In-Reply-To: <5141220A.7050008@gmail.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <5141220A.7050008@gmail.com>
Message-ID: <20130317181343.GB4394@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Hi Arnd/Olof,
> > 
> > Just 2 patches for mach-socfpga:
> > 
> > 0001: ARM: socfpga: Enable hotplug and soft reset
> > 	- Able to hotplug CPU1 by putting it into reset and bringing back online.
> > 
> 
> Have you seen the discussion on PSCI? There's an ARM doc on it and
> Linaro session from last week. Is there a possibility you can use that?
> You would need to be able to run in non-secure mode and implement
> smc calls.

What would be the advantage?

We do not have suitable hypervisor at the moment. Nor I see why it
would be good to push power management into it.

(Plus, the implementation seems pretty incomplete for arm32.).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
