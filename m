From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 12 Aug 2010 16:30:40 +0200
Subject: [PATCH v4] arm: msm: Add MSM IOMMU support.
In-Reply-To: <1281469529-23340-1-git-send-email-stepanm@codeaurora.org>
References: <1281469529-23340-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <20100812143040.GX23755@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stepan,

On Tue, Aug 10, 2010 at 12:45:29PM -0700, Stepan Moskovchenko wrote:
> Add support for the IOMMUs found on the upcoming Qualcomm
> MSM8x60 chips. These IOMMUs allow virtualization of the
> address space used by most of the multimedia cores on these
> chips. The driver implements the kernel's IOMMU API.

Using the IOMMU-API seems to work out well for this at the first glance.
I will give your patch a more deep review next week when I am back in
office. I really appreciate that your work fits into the IOMMU-API now.

So long,

   Joerg
