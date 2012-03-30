From: linux@baker-net.org.uk (Adam Baker)
Date: Fri, 30 Mar 2012 23:30:49 +0100
Subject: Support for Iomega iConnect
Message-ID: <201203302330.49834.linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is anyone aware of any technical reason why support for the Iomega iConnect is 
not included in the mainline kernel (e.g. there are significant changes 
happening in the area of the Kirkwood CPUs that mean now isn't a good time to 
include it). There are several versions floating around the internet but as far 
as I can see the only mention of the iConnect on this list is Russell saying 
he will remove it from mach types soon as there is no mainline support for it.

Based upon work that Iomega posted to the open source code area on their web 
site and code that was submitted to OpenWRT with a sign off line from Wojciech 
Dubowik, I have patched support into the 3.2.11 kernel. If there is no 
objection in principle to inclusion then I will rebase the patch and submit 
it.

Is Linus' git repository still the preferred baseline for linux-arm patches?

Regards

Adam Baker
