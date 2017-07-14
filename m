From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 14 Jul 2017 12:01:31 -0500
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20170714164455.GM20973@minitux>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714164455.GM20973@minitux>
Message-ID: <be10e365-95fa-dfa4-9900-4af05d8f41a9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2017 11:44 AM, Bjorn Andersson wrote:
> We would have to drop the "const" on the groups arrays of the other
> platform in order to use this, but I don't have a better suggestion at
> this time.

Why?  I don't modify any data in this patch, and I build just fine with 
these options enabled:

CONFIG_PINCTRL_MSM8916=y
CONFIG_PINCTRL_MSM8994=y
CONFIG_PINCTRL_MSM8996=y
CONFIG_PINCTRL_QDF2XXX=m

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
