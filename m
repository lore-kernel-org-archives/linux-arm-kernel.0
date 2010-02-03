From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 20:25:10 +0100
Subject: [PATCH 01/16] ARM: LPC32XX: clock lookups array should not be
	tagged __initdata
In-Reply-To: <20100203100803.GA22275@n2100.arm.linux.org.uk>
References: <1265155168-28909-2-git-send-email-wellsk40@gmail.com>
	<20100203100803.GA22275@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F805C8B787AC@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Tue, Feb 02, 2010 at 03:59:13PM -0800, wellsk40 at gmail.com wrote:
> > From: Kevin Wells <wellsk40@gmail.com>
> >
> > struct clk looksup[] should not be tagged with the __initdata
> > attribute so system functions after bootup can use the clkdev
> > support.
> 
> Can you roll this into your previous patch set please?

Hi Russell,

I'll fix the many more comments from the reviews and put up another
(hopefully last) set of patches that are sparse and bisect safe and
hopefully review safe. I would like to get these in patch tracker if
all goes good.

thanks,
Kevin
