From: jroedel@suse.de (Joerg Roedel)
Date: Thu, 7 Jul 2016 17:32:37 +0200
Subject: next-20160707 build: 1 failures 6 warnings (next-20160707)
In-Reply-To: <CAAFQd5DacKar+T1Fj62NvAZOT_QWBhahftZJXGq40Z19n-Z4Hg@mail.gmail.com>
References: <E1bL5XI-0004Z9-EP@optimist> <20160707122219.GO6247@sirena.org.uk>
 <CAAFQd5DacKar+T1Fj62NvAZOT_QWBhahftZJXGq40Z19n-Z4Hg@mail.gmail.com>
Message-ID: <20160707153237.GF11467@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 10:18:02PM +0900, Tomasz Figa wrote:
> This is probably because we missed this hidden dependency and decided
> to push the IOMMU part separately through the IOMMU tree. I guess we
> can remove the offending patch from the IOMMU tree and let the DRM
> tree include it based on a topic branch from Joerg.
> 
> Joerg, David, Mark Yao, what do you think?

Will the DRM patches go upstream soon, or is there still discussion
around them? For now I am going to remove/revert that patch in my tree.


	Joerg
