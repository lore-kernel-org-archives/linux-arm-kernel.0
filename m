From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 28 Jul 2015 14:56:59 -0700
Subject: [PATCH 2/7] clk: atlas7: export mux clks so that driver can use it
In-Reply-To: <1438064845-17894-3-git-send-email-21cnbao@gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-3-git-send-email-21cnbao@gmail.com>
Message-ID: <55B7FAAB.8070801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 11:27 PM, Barry Song wrote:
> From: Guo Zeng <guo.zeng@csr.com>
>
> this patch makes mux clks can be referenced by device drivers.
>
> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
> Signed-off-by: Barry Song <Barry.Song@csr.com>
> ---

The subject makes this sounds like we're exporting clocks to drivers via
extern, but that's not happening. Perhaps the subject could be clarified
to say something like "export mux clks so that consumers can get them"?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
