From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 27 Jan 2017 13:18:15 -0600
Subject: [PATCH v4 2/4] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170125155232.10277-2-cov@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-2-cov@codeaurora.org>
Message-ID: <6ff1f71f-8d28-81cb-b4b5-0617604ba153@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 09:52 AM, Christopher Covington wrote:
> +		.desc = "Qualcomm Falkor erratum 1003",

FYI, this needs to say, "Qualcomm Technologies Falkor ...".  Same thing with 
the 1009 patch.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
