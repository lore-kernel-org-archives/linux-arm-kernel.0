From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Oct 2017 09:36:54 +0100
Subject: [PATCH v2] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
 STE.S1STALLD and CD.S
In-Reply-To: <7eb1db90-9a30-b70c-c3d1-71bbca41502d@huawei.com>
References: <1505997367-51569-1-git-send-email-xieyisheng1@huawei.com>
 <7eb1db90-9a30-b70c-c3d1-71bbca41502d@huawei.com>
Message-ID: <20171020083653.GA17938@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 03:00:01PM +0800, Yisheng Xie wrote:
> Any comment about this version?

I have it queued up and plan to send a pull request to Joerg today for 4.15.

Will
