From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 14 Jul 2017 09:54:45 -0400
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
Message-ID: <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2017 9:26 PM, Ding Tianhong wrote:
> There is no code to enable the PCIe Relaxed Ordering bit in the configuration space,
> it is only be enable by default according to the PCIe Standard Specification, what we
> do is to distinguish the RC problematic platform and clear the Relaxed Ordering bit
> to tell the PCIe EP don't send any TLPs with Relaxed Ordering Attributes to the Root
> Complex.

Maybe, you should change the patch commit as 
"Disable PCIe Relaxed Ordering if not supported"...

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
