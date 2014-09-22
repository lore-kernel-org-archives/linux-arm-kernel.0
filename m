From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 18:35:25 +0100
Subject: [RFC PATCH v3 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <541AECDA.1000805@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-2-git-send-email-will.deacon@arm.com>
 <541AECDA.1000805@arm.com>
Message-ID: <20140922173525.GH7936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 03:31:54PM +0100, Robin Murphy wrote:
> After some fun times wondering why on Earth of_iommu_init was trying to 
> instantiate a GIC, I think we may need one of these as part of this 
> patch, too ;)

Oops, thanks!

Will
