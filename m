From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 11 Sep 2014 11:53:01 -0700
Subject: [PATCH 0/2] iommu/arm-smmu: hard iova_to_phys
In-Reply-To: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Thu, 11 Sep 2014 11:30:42 -0700")
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkwmwa6vvjm.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11 2014 at 11:30:42 AM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> This series introduces support for performing iova-to-phys translations via
> the ARM SMMU hardware on supported implementations. We also make use of
> some new generic macros for polling hardware registers.
>
> The iopoll macros were previously discussed here:
> http://marc.info/?l=linux-arm-kernel&m=140414727509158

Forgot to reference the previous disussion on the iova_to_phys
patch. Here it is:

    http://marc.info/?m=140789123928103

>
>
> Matt Wagantall (1):
>   iopoll: Introduce memory-mapped IO polling macros
>
> Mitchel Humpherys (1):
>   iommu/arm-smmu: add support for iova_to_phys through ATS1PR
>
>  drivers/iommu/arm-smmu.c |  73 +++++++++++++++++++++++++++++-
>  include/linux/iopoll.h   | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/iopoll.h



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
