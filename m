From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 1 Feb 2013 04:22:44 +0000 (UTC)
Subject: Existing queued v3.8-rc fixes postponed to v3.9
Message-ID: <alpine.DEB.2.00.1302010415370.32268@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

so, v3.8-rc6 is out, and based on Linus' release message:

http://marc.info/?l=linux-kernel&m=135968304820921&w=2

he only wants to see patches that "fix major security issues, big 
user-reported regressions, or nasty oopses".

So as a result the fixes that you've recently sent will be deferred to the 
v3.9 merge window.

...

As far as the OMAP4 PM stuff goes, I'm pretty disappointed that v3.8 is 
going to be released with non-obvious bootloader dependencies for 
full-chip power management.  Let's get the warning patch written and 
posted right away so it can go in during the v3.9 merge window.


- Paul
