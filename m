From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 30 Aug 2011 11:36:55 +0100
Subject: Merging Cadence macb/gem patches
Message-ID: <20110830103655.GE5414@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I have a series of patches[1] to add support for the Cadence GEM 
Ethernet MAC to the macb driver.  A while back, DaveM said that he would 
be happy for these to go through an ARM tree[2], so would you pull these 
into the arm-soc tree?

At the moment my patches are based on 3.1-rc1, but since then the 
drivers have been moved about and git merge doesn't seem to resolve 
this, so should I base them on the commit that moved them from the 
netdev tree?  I'm not sure how to handle this.

Thanks,

Jamie

1. http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060419.html
2. http://www.spinics.net/lists/arm-kernel/msg118717.html
