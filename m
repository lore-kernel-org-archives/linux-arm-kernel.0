From: joerg.roedel@amd.com (Joerg Roedel)
Date: Thu, 5 Jan 2012 12:47:32 +0100
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20120104212620.GG11810@n2100.arm.linux.org.uk>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
 <CAHQjnON3XYZ9cAK0kqsY4QzMzESD1wOzxt-fiQCq3TJfDObFiw@mail.gmail.com>
 <20120102155820.GB29877@amd.com>
 <20120103095527.GI2914@n2100.arm.linux.org.uk>
 <20120104150101.GA3492@amd.com>
 <20120104212620.GG11810@n2100.arm.linux.org.uk>
Message-ID: <20120105114732.GA7166@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 09:26:20PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 04, 2012 at 04:01:01PM +0100, Joerg Roedel wrote:
> > On Tue, Jan 03, 2012 at 09:55:27AM +0000, Russell King - ARM Linux wrote:
> > > It comes through when I stick it in my tree because of a month of asking
> > > for help to fix something and getting zero response from the maintainers.
> > > 
> > > It's a way to flag to them that they're doing something wrong - and in
> > > fact something is broken, and that that brokenness will happen at the
> > > next merge window unless they get off their butt and do something about
> > > it.
> > 
> > Okay, fine with me if it really will be fixed in 3.3-rc1 :)
> 
> I can do better than that - and report that it's fixed now.  It should
> show up in linux-next sometime after Stephen pulls this evening.  The
> #error did its job in this case, and ensured that it got fixed!

Great. So it looks like I can finally compile-test Exynos and merge
their IOMMU driver after the merge window :)

Thanks,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
