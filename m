From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 17:04:36 -0700
Subject: [PATCH v3 06/10] clk: iproc: Split off dig_filter
In-Reply-To: <1444938513-10758-7-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-7-git-send-email-jonmason@broadcom.com>
Message-ID: <20151022000436.GT19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> The PLL loop filter/gain can be located in a separate register on some
> SoCs.  Split these off into a separate variable, so that an offset can
> be added if necessary.  Also, make the necessary modifications to the
> Cygnus and NSP drivers for this change.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-iproc

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
