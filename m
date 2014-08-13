From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 13 Aug 2014 09:53:15 -0700
Subject: [PATCH 4/6] iommu/arm-smmu: implement generic DT bindings
In-Reply-To: <1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Tue, 12 Aug 2014 17:51:37 -0700")
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
 <1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkwfvh0pc04.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12 2014 at 05:51:37 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> Generic IOMMU device tree bindings were recently added in
> ["devicetree: Add generic IOMMU device tree bindings"]. Implement the
> bindings in the ARM SMMU driver.
>
> See Documentation/devicetree/bindings/iommu/iommu.txt for the bindings
> themselves.
>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 87 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 64 insertions(+), 23 deletions(-)

Ah just realized I didn't update the bindings documentation in
arm,smmu.txt. Will update in v2 along with any other feedback.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
