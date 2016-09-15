From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Sep 2016 17:24:58 -0700
Subject: [PATCH v2] clk: iproc: Make clocks visible options
In-Reply-To: <1446151450-23563-1-git-send-email-jonmason@broadcom.com>
References: <1446151450-23563-1-git-send-email-jonmason@broadcom.com>
Message-ID: <20160915002458.GI7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29, Jon Mason wrote:
> Make the clocks visible options that can be selected by anyone.  This
> avoids the problems of:
>  1) Select is a reverse dependency and is hard for people to understand
>     and can sometimes be a pain to track down
>  2) Build coverage goes down because configs are hidden
>  3) Code bloat
> 
> Patch suggested by Stephen Boyd
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-next with some minor fixup in the Makefile. I know
this is almost a year old, but it still mostly applied.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
