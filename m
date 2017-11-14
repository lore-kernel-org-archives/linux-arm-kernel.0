From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Nov 2017 15:53:54 -0800
Subject: [PATCH RESEND] clk: sunxi-ng: a83t: Fix i2c buses bits
In-Reply-To: <20171105165134.5199-1-mylene.josserand@free-electrons.com>
References: <20171105165134.5199-1-mylene.josserand@free-electrons.com>
Message-ID: <20171114235354.GG11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05, Myl?ne Josserand wrote:
> i2c1 and i2c2 bits for CCU are not bit 0 but bit 1 and bit 2.
> Because of that, the i2c0 (bit 0) was not correctly configured.
> Fixed the correct bits for i2c1 and i2c2.
> 
> Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
