From: tj@kernel.org (Tejun Heo)
Date: Tue, 28 Mar 2017 11:55:12 -0400
Subject: [PATCH v2 08/22] lib: implement Devres ioremap_nopost() interface
In-Reply-To: <20170328145003.GB18046@red-moon>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-9-lorenzo.pieralisi@arm.com>
 <20170328014129.GJ25380@bhelgaas-glaptop.roam.corp.google.com>
 <20170328145003.GB18046@red-moon>
Message-ID: <20170328155512.GA28157@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 28, 2017 at 03:50:03PM +0100, Lorenzo Pieralisi wrote:
> > I know this comment was just copied from other devm_ioremap*()
> > interfaces, but I think it's slightly misleading to call this the "BUS
> > offset".  That suggests this is a bus address, but it is not.  Maybe
> > it should be "resource address" or similar?
> > 
> > I propose a separate patch to update the existing comments, followed
> > by this patch to add this new one.
> 
> I agree with you, maybe Tejun has more context on why that parameter
> is called BUS offset ? Anyway, I can easily do what you suggest above,
> just asking Tejun if there is something I am missing.

I'm pretty sure I copied it from somewhere without thinking much about
it.  Please feel free to change.

Thanks.

-- 
tejun
