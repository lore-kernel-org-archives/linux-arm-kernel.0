From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 12 Jul 2016 15:59:04 +0200
Subject: next-20160707 build: 1 failures 6 warnings (next-20160707)
In-Reply-To: <20160707153237.GF11467@suse.de>
References: <E1bL5XI-0004Z9-EP@optimist> <20160707122219.GO6247@sirena.org.uk>
 <CAAFQd5DacKar+T1Fj62NvAZOT_QWBhahftZJXGq40Z19n-Z4Hg@mail.gmail.com>
 <20160707153237.GF11467@suse.de>
Message-ID: <20160712135904.GJ23520@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 05:32:37PM +0200, Joerg Roedel wrote:
> On Thu, Jul 07, 2016 at 10:18:02PM +0900, Tomasz Figa wrote:
> > This is probably because we missed this hidden dependency and decided
> > to push the IOMMU part separately through the IOMMU tree. I guess we
> > can remove the offending patch from the IOMMU tree and let the DRM
> > tree include it based on a topic branch from Joerg.
> > 
> > Joerg, David, Mark Yao, what do you think?
> 
> Will the DRM patches go upstream soon, or is there still discussion
> around them? For now I am going to remove/revert that patch in my tree.

drm is pretty much done for 4.8, but as usual there's some driver
maintainers who are rather late. I'd say unlikely it lands in 4.8,
postpone to 4.9 seems more reasonable given the trouble it just caused.
-Daniel

> 
> 
> 	Joerg
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
