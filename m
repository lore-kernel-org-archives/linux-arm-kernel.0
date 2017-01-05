From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 5 Jan 2017 09:53:26 +0000
Subject: [PATCH v6 03/14] ACPI: ARM64: IORT: add missing comment for
 iort_dev_find_its_id()
In-Reply-To: <4915fe90-ea61-45b5-491d-0628456abed2@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-4-git-send-email-hanjun.guo@linaro.org>
 <20170104143442.GA8604@red-moon>
 <4915fe90-ea61-45b5-491d-0628456abed2@linaro.org>
Message-ID: <20170105095326.GA8988@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 02:05:06PM +0800, Hanjun Guo wrote:
> On 2017/1/4 22:34, Lorenzo Pieralisi wrote:
> >On Mon, Jan 02, 2017 at 09:31:34PM +0800, Hanjun Guo wrote:
> >>We are missing req_id's comment for iort_dev_find_its_id(),
> >>add it back.
> >
> >"Add missing req_id parameter to the iort_dev_find_its_id() function
> >kernel-doc comment."
> >
> >>Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>Tested-by: Majun <majun258@huawei.com>
> >>Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> >>Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>Cc: Tomasz Nowicki <tn@semihalf.com>
> >>---
> >> drivers/acpi/arm64/iort.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >>
> >>diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>index 46e2d82..174e983 100644
> >>--- a/drivers/acpi/arm64/iort.c
> >>+++ b/drivers/acpi/arm64/iort.c
> >>@@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
> >> /**
> >>  * iort_dev_find_its_id() - Find the ITS identifier for a device
> >>  * @dev: The device.
> >>+ * @req_id: Device's Requster ID
> >
> >s/Requster/Requester
> >
> >We can send it upstream independently along with some other patches
> >in this series but I will have a look at the whole series first.
> 
> Do you mean go to 4.10-rcx?

Yes, technically it is a fix, not urgent at all though.

Lorenzo
