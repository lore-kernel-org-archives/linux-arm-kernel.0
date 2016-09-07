From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Sep 2016 14:27:20 -0700
Subject: [PATCH v5 2/6] clk: gxbb: expose MPLL2 clock for use by DT
In-Reply-To: <20160906213848.17785-3-martin.blumenstingl@googlemail.com>
References: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
 <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
 <20160906213848.17785-3-martin.blumenstingl@googlemail.com>
Message-ID: <20160907212720.GZ12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06, Martin Blumenstingl wrote:
> This exposes the MPLL2 clock as this is one of the input clocks of the
> ethernet controller's internal mux.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
