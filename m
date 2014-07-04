From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 4 Jul 2014 13:05:30 +0200
Subject: [RFC 01/10] iommu: Add IOMMU device registry
In-Reply-To: <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140704110529.GF13434@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> Add an IOMMU device registry for drivers to register with and implement
> a method for users of the IOMMU API to attach to an IOMMU device. This
> allows to support deferred probing and gives the IOMMU API a convenient
> hook to perform early initialization of a device if necessary.

Can you elaborate on why exactly you need this? The IOMMU-API is
designed to hide any details from the user about the available IOMMUs in
the system and which IOMMU handles which device. This looks like it is
going in a completly different direction from that.


	Joerg
