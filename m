From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Aug 2014 11:55:53 +0100
Subject: [PATCH v4 1/1] iommu/arm-smmu: Do not access non-existing S2CR
 registers
In-Reply-To: <20140826103730.GE23445@arm.com>
References: <1408752752-15601-1-git-send-email-ohaugan@codeaurora.org>
 <20140826103730.GE23445@arm.com>
Message-ID: <20140828105552.GI22580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:37:30AM +0100, Will Deacon wrote:
> On Sat, Aug 23, 2014 at 01:12:32AM +0100, Olav Haugan wrote:
> > The number of S2CR registers is not properly set when stream
> > matching is not supported. Fix this and add check that we do not try to
> > access outside of the number of S2CR regisrers.
> 
> Sorry for the bother, but could you base this on either iommu/devel or
> iommu/staging please? Now that the merge window is well and truly over, I
> moved those branches forward, so you needn't worry about iommu/pci anymore
> (which, as you pointed out, contains a bunch of WIP patches which should
> hold-up useful fixes like this one).

Actually, it looks like this was eaten by our sorry excuse for an email
service. I've managed to apply a version from the archive, thanks.

Will
