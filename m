From: pavel@denx.de (Pavel Machek)
Date: Thu, 14 Mar 2013 12:03:10 +0100
Subject: [PATCHv1 0/2] ARM: socfpga: Soft reset, hotplug and device
 tree clocks
In-Reply-To: <5141220A.7050008@gmail.com>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <5141220A.7050008@gmail.com>
Message-ID: <20130314110310.GA3384@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
 
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

I tried googling PSCI, but got:

Power State Coordination Interface
System Software on ARM Processors
This document is only available in a PDF version to registered ARM
customers.

Do you have better pointer?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
