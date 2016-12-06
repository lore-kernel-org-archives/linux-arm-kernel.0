From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Dec 2016 17:31:11 +0000
Subject: [PATCH V6 6/6] iommu/arm-smmu: Set privileged attribute to
 'default' instead of 'unprivileged'
In-Reply-To: <1480690509-13490-7-git-send-email-sricharan@codeaurora.org>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
 <1480690509-13490-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <20161206173110.GT2498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 08:25:09PM +0530, Sricharan R wrote:
> Currently the driver sets all the device transactions privileges
> to UNPRIVILEGED, but there are cases where the iommu masters wants
> to isolate privileged supervisor and unprivileged user.
> So don't override the privileged setting to unprivileged, instead
> set it to default as incoming and let it be controlled by the pagetable
> settings.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Acked-by: Will Deacon <will.deacon@arm.com>

I'll let you and Robin sort out what you want to do with this series :)

Will
