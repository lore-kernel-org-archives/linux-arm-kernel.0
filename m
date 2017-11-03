From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 3 Nov 2017 08:11:00 -0700
Subject: [PATCH] clk: sunxi-ng: a83t: Fix i2c buses bits
In-Reply-To: <20171103105747.26335-1-mylene.josserand@free-electrons.com>
References: <20171103105747.26335-1-mylene.josserand@free-electrons.com>
Message-ID: <20171103151100.GR11011@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03, Myl?ne Josserand wrote:
> i2c1 and i2c2 bits for CCU are not bit 0 but bit 1 and bit 2.
> Because of that, the i2c0 (bit 0) was not correctly configured.
> Fixed the correct bits for i2c1 and i2c2.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---

Please add a Fixes tag.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
