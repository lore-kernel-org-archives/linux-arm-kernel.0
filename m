From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 15:06:36 -0800
Subject: [PATCH 2/2] clk: bcm: Allow rate change propagation to PLLH_AUX
 on VEC clock
In-Reply-To: <1480626020-20031-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480626020-20031-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20161208230636.GT5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01, Boris Brezillon wrote:
> The VEC clock requires needs to be set at exactly 108MHz. Allow rate
> change propagation on PLLH_AUX to match this requirement wihtout
> impacting other IPs (PLLH is currently only used by the HDMI encoder,
> which cannot be enabled when the VEC encoder is enabled).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
