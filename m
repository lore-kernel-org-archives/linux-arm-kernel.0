From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 25 Jan 2018 14:48:42 -0600
Subject: [PATCH 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <20180110015848.11480-4-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-4-sboyd@codeaurora.org>
Message-ID: <dcbc067c-4baf-8814-a8a1-582a4dd3e500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2018 07:58 PM, Stephen Boyd wrote:
> +static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)

"unsigned int", instead of just "unsigned"?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
