From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Aug 2015 10:34:57 +0800
Subject: [GIT PULL] i.MX clock updates for 4.2
In-Reply-To: <20150811174657.2416.1270@quantum>
References: <20150811085921.GB10035@tiger> <20150811174657.2416.1270@quantum>
Message-ID: <20150812023456.GC10035@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 10:46:57AM -0700, Michael Turquette wrote:
> Hi Shawn,
> 
> Quoting Shawn Guo (2015-08-11 01:59:21)
> > Hi Michael, Stephen,
> > 
> > The i.MX clock drivers were moved into drivers/clk/imx folder since
> > v4.2-rc1, so I would like to send i.MX clock changes through clock tree
> > from this cycle.  Here is my first pull request to you guys.  I'm using
> > signed tags, same as how I work with arm-soc folks.  Let me know if
> > there is any problem with it.
> 
> Everything looks good. Pulled.

Thanks, Mike.

> 
> > 
> > Also, please keep it stable, because I need to pull it into other
> > branch as dependency which I will send via arm-soc tree.
> 
> Will do.
> 
> Also, the clock driver was not Cc'd to linux-clk mailing list nor did it
> Cc myself or Stephen. I've taken a quick look at it and it seems fine,
> but please post clk patches to the linux-clk mailing list in the future.

I will ensure that all i.MX clock patches get Cc'd to linux-clk and you
guys in the future.

Shawn
