From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Sat, 27 Sep 2014 20:22:33 -0700
Subject: [PATCH v2 0/2] iommu/arm-smmu: hard iova_to_phys
In-Reply-To: <1411853513-9571-1-git-send-email-mitchelh@codeaurora.org>
 (Mitchel Humpherys's message of "Sat, 27 Sep 2014 14:31:51 -0700")
References: <1411853513-9571-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <vnkw8ul4mnt2.fsf@mitchelh-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27 2014 at 02:31:51 PM, Mitchel Humpherys <mitchelh@codeaurora.org> wrote:
> This series introduces support for performing iova-to-phys translations via
> the ARM SMMU hardware on supported implementations. We also make use of
> some new generic macros for polling hardware registers.
>
> Changes since v1:
>
>   - Renamed one of the iopoll macros to use the more standard `_atomic'
>     suffix
>   - Removed some convenience iopoll wrappers to encourage explicitness

Hold on, just remembered there was another comment on the iova_to_phys
patch.  v3 is en route...



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
