From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Dec 2016 17:08:21 -0600
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161229224335.13531-2-cov@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
Message-ID: <ac275374-2aa6-43ec-25c9-6a3fec4ceedc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2016 04:43 PM, Christopher Covington wrote:
> +config QCOM_FALKOR_E1003_RESERVED_ASID
> +	int
> +	default 1
> +	depends on QCOM_FALKOR_ERRATUM_1003

Also, since this can't be changed via the menu, why bother putting it in?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
