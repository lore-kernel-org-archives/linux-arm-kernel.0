From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 17:30:54 -0700
Subject: [PATCH 7/7] clk: atlas7: fix pll missed divide NR in fraction mode
In-Reply-To: <1438699532-13860-8-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
 <1438699532-13860-8-git-send-email-21cnbao@gmail.com>
Message-ID: <20150812002805.GH26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04, Barry Song wrote:
> From: Guo Zeng <guo.zeng@csr.com>
> 
> PLL VCO frequency is given by Fvco = Fref * 2 * NF / NR
> in integer-N mode, or by Fvco = Fref * SSN / NR in Spread
> Spectrum (fractional-N) mode. Thus fix the missing part
> of NR
> 
> Signed-off-by: Guo Zeng <guo.zeng@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
