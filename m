From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Jun 2017 18:11:57 +0100
Subject: [PATCH v2] iommu/arm-smmu-v3: Implement shutdown method
In-Reply-To: <1498774696-16037-1-git-send-email-nwatters@codeaurora.org>
References: <1498774696-16037-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20170630171156.GB15682@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 06:18:15PM -0400, Nate Watterson wrote:
> The shutdown method disables the SMMU to avoid corrupting a new kernel
> started with kexec.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 +++++++
>  drivers/iommu/arm-smmu.c    | 6 ++++++
>  2 files changed, 13 insertions(+)

Aha, I didn't see you'd dropped the IRQ changes here :)

In which case, this looks fine to me, thanks!

Will
