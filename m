From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 16:54:49 -0700
Subject: [PATCH v3 04/10] clk: nsp: add clock support for Broadcom
 Northstar Plus SoC
In-Reply-To: <1444938513-10758-5-git-send-email-jonmason@broadcom.com>
References: <1444938513-10758-1-git-send-email-jonmason@broadcom.com>
 <1444938513-10758-5-git-send-email-jonmason@broadcom.com>
Message-ID: <20151021235449.GR19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, Jon Mason wrote:
> The Broadcom Northstar Plus SoC is architected under the iProc
> architecture. It has the following PLLs: ARMPLL, GENPLL, LCPLL0, all
> derived from an onboard crystal.
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---

Applied to clk-iproc

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
