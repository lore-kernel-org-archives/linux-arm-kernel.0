From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Jun 2017 17:38:38 -0500
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <20170628191204.GP18666@tuxbook>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
 <20170628191204.GP18666@tuxbook>
Message-ID: <d4ed2a91-5f19-fa04-42ed-02b94dde1b6e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 02:12 PM, Bjorn Andersson wrote:
> It seems that if we extend the msm_pingroup with a flag to carry the XPU
> lock information and then implement pinmux_ops->request() and deny any
> requests on the locked pins, we should cover all[*] the normal GPIO code
> paths.

I managed to get this to work, so I'll post a patchset by tomorrow that 
implements this.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
