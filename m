From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Mon, 19 May 2014 20:37:13 +0530
Subject: [PATCH 0/1] arm: dma-iommu: Clean up redundant variable
In-Reply-To: <1400511859-22286-1-git-send-email-ritesh.harjani@gmail.com>
References: <1400511859-22286-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <CAD15agbxvrypWN4f9b9J_ivSUK6uuTW_7ZzdHULEXs-n98w84g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

++ mailing lists

On Mon, May 19, 2014 at 8:34 PM,  <ritesh.harjani@gmail.com> wrote:
> From: Ritesh Harjani <ritesh.harjani@gmail.com>
>
> This redundant variable was identified by Will (cc'd) in below mentioned
> thread [1].
> It was discussed earlier that this variable will be cleaned up as part of
> dma-iommu refractoring code, but currently it has taken longer time then
> expected.
>
> So, submitting this small patch for review before we forget about it.
> [1]: http://www.spinics.net/lists/arm-kernel/msg324224.html
>
> Ritesh Harjani (1):
>   arm: dma-iommu: Clean up redundant variable
>
>  arch/arm/include/asm/dma-iommu.h |  1 -
>  arch/arm/mm/dma-mapping.c        | 11 ++++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> --
> 1.8.1.3
>
