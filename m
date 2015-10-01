From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 16:39:59 -0700
Subject: [PATCH] clk: imx: use sign_extend32() and abs()
In-Reply-To: <1443526347-15501-1-git-send-email-martink@posteo.de>
References: <1443526347-15501-1-git-send-email-martink@posteo.de>
Message-ID: <20151001233959.GZ19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29, Martin Kepplinger wrote:
> This simplifies the given function by getting rid of the manual
> sign extension as well as saving an absolute value in an extra
> variable.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
