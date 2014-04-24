From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 24 Apr 2014 17:49:06 -0500
Subject: socfpga in 3.15-rc2
In-Reply-To: <20140424152156.GA22540@amd.pavel.ucw.cz>
References: <20140424125421.GA19526@amd.pavel.ucw.cz>
 <734n1i25ad.fsf@unicorn.hi.pengutronix.de>
 <20140424152156.GA22540@amd.pavel.ucw.cz>
Message-ID: <1398379746.14881.3.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-04-24 at 17:21 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Does socfpga boot for you on 3.15-rc2? Mainline worked on 3.14 pretty
> > > well, but I get no output from serial from 3.15-rc2. Any ideas?
> > >
> > 
> > You need:
> > 
> > [PATCH] clk: socfpga: fix clock driver for 3.15
> > Message-Id: 1397481336-5592-1-git-send-email-dinguyen at altera.com
> 
> Thanks a lot, with that patch, I'm back to working system.

Glad you found it. Who's dinh at amd.pavel.ucw.cz?

Dinh
> 
> 									Pavel
