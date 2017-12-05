From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 5 Dec 2017 12:13:06 -0500
Subject: [PATCH V5 1/7] Documentation: DT: qcom_hidma: Bump HW revision
 for the bugfixed HW
In-Reply-To: <20171204221414.f5tphhn7gvlle3li@rob-hp-laptop>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
 <1512188864-773-2-git-send-email-okaya@codeaurora.org>
 <20171204221414.f5tphhn7gvlle3li@rob-hp-laptop>
Message-ID: <61d54e4c-5ec9-441e-07bf-598204d772c6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2017 5:14 PM, Rob Herring wrote:
> Hopefully 1.2 corresponds to some actual version numbering and not just 
> something you made up. I'd really rather have SoC based compatible 
> strings unless you have dozens of SoCs for each version. I'll probably 
> just say the same thing again when 1.3 or 2.0 gets added...
> 

No, these are coming from the HW. They are user visible. 

[  107.167207] hidma-mgmt QCOM8060:00: HW rev: 1.2 @ 0x0000ffff8b800000 with 6 physical channels

> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
