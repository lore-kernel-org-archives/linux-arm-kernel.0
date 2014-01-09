From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 Jan 2014 13:35:53 +0900
Subject: [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
In-Reply-To: <20140108112359.GA2669@katana>
References: <20131217050232.727.9552.sendpatchset@w520>
 <20131217050324.727.61701.sendpatchset@w520>
 <20131217163435.GC7071@katana> <20140108004157.GH5136@verge.net.au>
 <20140108112359.GA2669@katana>
Message-ID: <20140109043553.GB2132@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 12:23:59PM +0100, Wolfram Sang wrote:
> 
> > could you clarify the status of this patch for me?
> > 
> > I believe it is reverted by "[PATCH V2 4/5] arm: shmobile: genmai: adapt
> > dts to use native i2c driver".
> > 
> > I'm fine with applying both patches at some point. But perhaps
> > we can skip some dependencies by just applying a squashed version?
> 
> If we keep this patch and my one on top of it, we need the PFC series.
> If we skip this patch and use my native I2C right from the beginning, we
> can skip the PFC series and have i2c support right away. I'd prefer the
> latter. I am about to push a branch to my tree that does the latter
> these minutes.

I think I prefer the latter too.
