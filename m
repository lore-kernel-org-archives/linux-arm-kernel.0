From: j.neuschaefer@gmx.net (Jonathan =?utf-8?Q?Neusch=C3=A4fer?=)
Date: Tue, 16 May 2017 16:09:43 +0200
Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
In-Reply-To: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170516140943.ps2yufiukz6iurpl@latitude>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I have a few suggestions on how to make this commit message more
readable:

On Tue, May 16, 2017 at 10:54:13AM +0530, Sricharan R wrote:
> While returning EPROBE_DEFER for iommu masters

Add a comma at the end of this line

> take in to account of iommu nodes that could be

s/in to/into/
s/of iommu/of_iommu/

> marked in DT as 'status=disabled', in which case
> simply return NULL and let the master's probe
> continue rather than deferring.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>


Thanks,
Jonathan Neusch?fer
