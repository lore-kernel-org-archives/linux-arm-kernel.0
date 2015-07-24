From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 24 Jul 2015 12:39:01 +0100
Subject: [PATCH] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <20150724113149.GE4348@leverpostej>
References: <1437496204-5438-1-git-send-email-ian.campbell@citrix.com>
 <20150722084753.GC14923@e106497-lin.cambridge.arm.com>
 <1437558438.8383.72.camel@citrix.com> <20150724113149.GE4348@leverpostej>
Message-ID: <1437737941.24746.75.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-24 at 12:31 +0100, Mark Rutland wrote:
> On Wed, Jul 22, 2015 at 10:47:18AM +0100, Ian Campbell wrote:
> > On Wed, 2015-07-22 at 09:47 +0100, Liviu Dudau wrote:
> > > 
> > > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > 
> > Thanks.
> > 
> > > Picking your brains here: would it be worth to have some vendor 
> > > directories in
> > > this shared area or we can hope that there will be very few files 
> > > living here?
> > 
> > I'm honestly not sure.
> > 
> > I don't expect there will be very many files under here, and I 
> > would
> > expect the norm would be that common .dtsi files used by multiple
> > arches would be things from the same vendor, but I don't think we 
> > can
> > guarantee that.
> 
> I'm not so sure that this area will remain small. I suspect we'll see
> a reasonable amount of sharing for arm/arm64 where two SoCs differ 
> sith
> s/Cortex-A7/Cortex-A53/, for example.
> 
> Perhaps we could wait until the that starts to happen; we managed to
> survive for a while before moving arm64's dts into subdirs.

If we think it is inevitable we may as well bite the bullet, plus I've
already done "git commit --amend" to move it to include/dt-dtsi/arm ;-)

Ian. 
