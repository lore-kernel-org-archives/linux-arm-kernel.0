From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 18 Aug 2011 12:05:01 +0300
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <201108181101.57882.laurent.pinchart@ideasonboard.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<201108181101.57882.laurent.pinchart@ideasonboard.com>
Message-ID: <CAK=Wgbb6EWBr9ndCEGK2C6kK74B8vNFpezw-=ndEQ4bANhOB4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Thu, Aug 18, 2011 at 12:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Just one small comment in case you resubmit the whole series for another
> reason.
..
> You can directly return -ENOMEM here, and remove the "out:" label.

Sure thing,

Thanks,
Ohad.
