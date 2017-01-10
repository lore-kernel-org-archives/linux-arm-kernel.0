From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 10 Jan 2017 18:14:44 +0100
Subject: [PATCH v7 08/19] iommu: Implement reserved_regions iommu-group
 sysfs file
In-Reply-To: <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-9-git-send-email-eric.auger@redhat.com>
 <9ee5aa6b-6e63-c153-0727-729e0e9592c6@redhat.com>
Message-ID: <20170110171444.GU17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 05:20:34PM +0100, Auger Eric wrote:
> The /sys/kernel/iommu_groups/n directory seems to be removed before this
> gets called and this may produce a WARNING when devices get removed from
> the group. I intend to remove the call since I have the feeling
> everything gets cleaned up properly.

A feeling is not enough, please check that in the code.


	Joerg
