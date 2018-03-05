From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 5 Mar 2018 16:53:17 -0500
Subject: [PATCH 07/37] iommu: Add a page fault handler
In-Reply-To: <20180212183352.22730-8-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-8-jean-philippe.brucker@arm.com>
Message-ID: <77afa195-4842-a112-eba5-409b861b5315@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static struct workqueue_struct *iommu_fault_queue;

Is there anyway we can make this fault queue per struct device?
Since this is common code, I think it needs some care.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
