From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Jun 2013 18:29:52 -0700
Subject: [PATCH/RESEND 00/12] Convert MSM to common clock framework
In-Reply-To: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130621012952.GE6300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17, Stephen Boyd wrote:
> Resending to collect higher level maintainer acks per Olof's request. 
> The plan is to push this patchset through MSM to the arm-soc tree.
> 
> This patchset moves the existing MSM clock code and affected drivers to the
> common clock framework. A prerequisite of moving to the common clock
> framework is to use clk_prepare() and clk_enable() so the first
> few patches migrate drivers to that call (clk_prepare() is a no-op on MSM
> right now). It also removes some custom clock APIs that MSM provides
> and finally moves the proc_comm clock code to the common struct clk.
> 
> This patch series will be used as the foundation of the MSM 8660/8960
> clock code that I plan to send out after this series.
> 

David, can you pick this up and send it off to arm-soc now?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
