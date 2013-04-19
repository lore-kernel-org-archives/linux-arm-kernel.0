From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 19 Apr 2013 23:11:06 +0530
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130419171318.GK10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Message-ID: <517181B2.9070302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> Hi all,
> 
> Here's a list of breakage I've noticed so far while trying to
> use linux next on my pandaboard es. Probably similar issues exist
> on other boards as well.
> 
> Ideally we would not have any breakage by the merge window, so
> let's try to get these fixed ASAP:
> 
> 1. Serial console broken on panda es booting with DT
> 
> The symptoms are dmesg output stopping after few lines
> and only continuing after pressing a key. Does not seem to
> happen on blaze with DT for some reason. And does not happen
> on panda es with legacy booting.
> 
This one is known and reported on list along with fix patches and
later pull request [1].

Unfortunately with all the testing and everything and patches have
been on the list for quite some time, feedback on one of the patch
received was after pull request and then there was no further
clarification. That series address the same exact issue you have
mentioned above.

Regards,
Santosh
[1] http://patchwork.ozlabs.org/patch/229269/
