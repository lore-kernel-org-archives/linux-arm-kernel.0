From: davidb@codeaurora.org (David Brown)
Date: Sat, 24 Sep 2011 22:03:08 -0700
Subject: [PATCH v3 3/6] iommu/msm: announce supported page sizes
In-Reply-To: <1316195506-9777-4-git-send-email-ohad@wizery.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
	<1316195506-9777-4-git-send-email-ohad@wizery.com>
Message-ID: <20110925050308.GA6493@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 08:51:43PM +0300, Ohad Ben-Cohen wrote:
> Let the IOMMU core know we support 4KiB, 64KiB, 1MiB and 16MiB page sizes.
> 
> This way the IOMMU core can split any arbitrary-sized physically
> contiguous regions (that it needs to map) as needed.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
>  drivers/iommu/msm_iommu.c |    8 +++++++-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
