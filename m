From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 17:25:16 -0700
Subject: [PATCH v3 08/10] clk: ns2: add clock support for Broadcom
 Northstar 2 SoC
In-Reply-To: <1444938513-10758-9-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-9-git-send-email-jonmason@broadcom.com>
Message-ID: <20151022002516.GW19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> The Broadcom Northstar 2 SoC is architected under the iProc
> architecture. It has the following PLLs: GENPLL SCR, GENPLL SW,
> LCPLL DDR, LCPLL Ports, all derived from an onboard crystal.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-iproc

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
