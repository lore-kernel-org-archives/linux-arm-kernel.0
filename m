From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Feb 2016 09:30:45 +0100
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <20160217102124.7353591f@xhacker>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160216134219.00045b5b@xhacker>
 <20160216173840.7f93896f@free-electrons.com>
 <20160217102124.7353591f@xhacker>
Message-ID: <20160217093045.457e6a54@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 17 Feb 2016 10:21:24 +0800, Jisheng Zhang wrote:

> > > I guess the GIC is neither the one in cortex-a15 or cortex-a9.   
> > 
> > What makes you think this?
> > 
> > The GIC is a GIC400, which is GICv2 compliant, and arm-cortex-a15-gic /
> 
> That's my point, why not "gic-400" explicitly?

Yes, we could use arm,gic-400 instead. Note that implementation-wise,
there is currently zero difference between arm,cortex-a9-gic,
arm,cortex-a15-gic and arm,gic-400. But indeed arm,gic-400 looks better.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
