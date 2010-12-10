From: cjb@laptop.org (Chris Ball)
Date: Fri, 10 Dec 2010 16:07:25 +0000
Subject: [PATCH] mmci: drop superfluous regulator #ifdef
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A075EE07B17@EXDCVYMBSTM006.EQ1STM.local>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
	<20101210033908.GA4455@void.printf.net>
	<20101210081202.GA19186@n2100.arm.linux.org.uk>
	<CEE6BB42CAD6E947908279175AF8470A075EE07B17@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <20101210160724.GA11612@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 10, 2010 at 10:30:05AM +0100, Linus WALLEIJ wrote:
> > > Thanks, pushed to mmc-next for .38.
> > 
> > Also queued in the ARM tree.
> 
> Chris, Russell is listed as maintainer for this driver so
> he probably prefers to take in changes to it through the ARM
> tree, can you take this patch out of the mmc tree?

Oops, my apologies, didn't think of that.  Removed from mmc-next, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
