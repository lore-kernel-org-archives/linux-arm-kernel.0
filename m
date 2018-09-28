From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Sep 2018 14:36:40 +0100
Subject: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Message-ID: <20180928133639.GF1577@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 05:10:20PM +0100, Robin Murphy wrote:
> Hopefully this is the last spin of the series - I've now dropped my light
> touch and fixed up all the various prose text, plus implemented the proper
> quirk support for short-descriptor because it's actually just a trivial
> cut-and-paste job.

Did you manage to clarify how the lifetime of the domain/flush queue interacts
with the periodic timer after the cookie has been freed?

Will
