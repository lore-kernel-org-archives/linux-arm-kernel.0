From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 29 Nov 2016 13:12:29 -0800
Subject: [PATCH v2 2/3] clk: uniphier: add CPU-gear change (cpufreq)
 support
In-Reply-To: <1479967061-25975-2-git-send-email-yamada.masahiro@socionext.com>
References: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
 <1479967061-25975-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161129211229.GF6095@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24, Masahiro Yamada wrote:
> Core support code for CPU frequency changes, which will be used by
> the generic cpufreq driver.
> 
> The register view is different from the generic clk-mux; it has
> a separate status register, and an update bit to load the register
> setting.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
