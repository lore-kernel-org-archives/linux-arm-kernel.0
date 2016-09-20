From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 16:58:42 -0700
Subject: [PATCH 2/2] clk: imx6: initialize GPU clocks
In-Reply-To: <1474017371-28966-2-git-send-email-l.stach@pengutronix.de>
References: <1474017371-28966-1-git-send-email-l.stach@pengutronix.de>
 <1474017371-28966-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <20160920235842.GG8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16, Lucas Stach wrote:
> Initialize the GPU clock muxes to sane inputs. Until now they have
> not been changed from their default values, which means that both
> GPU3D shader and GPU2D core were fed by clock inputs whose rates
> exceed the maximium allowed frequency of the cores by as much as
> 200MHz.
> 
> This fixes a severe GPU stability issue on i.MX6DL.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
