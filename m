From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:03:16 -0800
Subject: [PATCH V7 11/12] arm64: dts: add syscon for whale2 platform
In-Reply-To: <20171207125715.16160-12-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-12-chunyan.zhang@spreadtrum.com>
Message-ID: <20171221230316.GY7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07, Chunyan Zhang wrote:
> Some clocks on SC9860 are in the same address area with syscon
> devices, the proper syscon node will be quoted under the
> definitions of those clocks in DT.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---

These last two can go via arm-soc?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
