From: ijc@debian.org (Ian Campbell)
Date: Fri, 21 Aug 2015 21:23:46 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20150821130725.GA6108@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150821130725.GA6108@lunn.ch>
Message-ID: <1440188626.23097.35.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-21 at 15:07 +0200, Andrew Lunn wrote:
> On Fri, Aug 21, 2015 at 01:24:17PM +0100, Ian Campbell wrote:
> > Hi kirkwood-upstream,
> 
> Hi Ian
> 
> Thanks for forwarding the reports to us. I will try to reproduce it on my
> TS-119P.

No problem.

BTW maybe Debian bug #794265[0] is related, it is "flash-kernel
subsequent actions result in segfault" where "flash-kernel" is the tool
which writes the mtdblock device (causing SATA issues in the original
mail).

> I'm travelling for the next 10 days, so it may take a while.

Ack. FYI I'll be on vacation from Sunday for a week.

Cheer,
Ian.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=794265
