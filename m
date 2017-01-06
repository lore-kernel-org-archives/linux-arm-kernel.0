From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 6 Jan 2017 13:48:16 +0100
Subject: [PATCH v6 07/18] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <888d3750-817c-77d1-8154-e77cf8c3ad4b@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-8-git-send-email-eric.auger@redhat.com>
 <20170106110039.GL17255@8bytes.org>
 <888d3750-817c-77d1-8154-e77cf8c3ad4b@redhat.com>
Message-ID: <20170106124816.GQ17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 12:46:05PM +0100, Auger Eric wrote:
> On 06/01/2017 12:00, Joerg Roedel wrote:

> > I think it also makes sense to report the type of the reserved region.
> 
> What is the best practice in that case? Shall we put the type enum
> values as strings such as:
> - direct
> - nomap
> - msi
> 
> and document that in Documentation/ABI/testing/sysfs-kernel-iommu_groups

Yes, a string would be good. An probably 'reserved' is a better name
than nomap?


	Joerg
