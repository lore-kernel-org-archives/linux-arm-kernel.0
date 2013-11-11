From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 11 Nov 2013 13:03:52 +0100
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
In-Reply-To: <20131111113510.GG28302@mudshark.cambridge.arm.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com><1384158718-4756-6-git-send-email-hdoyu@nvidia.com><20131111113510.GG28302@mudshark.cambridge.arm.com>
Message-ID: <20131111.140352.730622703500692694.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> wrote @ Mon, 11 Nov 2013 12:35:10 +0100:

> This code looks familiar ;)

;)
 
> If this approach makes it past the DT guys, I wonder if there's any scope
> for factoring out some of the arm-smmu code so that basic client
> parsing/searching/registration can be made into a library?

That's what I thought too. I just didn't proceed further till I get
some feedback on this design first. As you suggested, some of arm,smmu
part can be enough generic so that some other of IOMMU drivers can
make use of that as a library.
