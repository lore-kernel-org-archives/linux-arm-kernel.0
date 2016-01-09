From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jan 2016 22:41:30 -0600
Subject: [PATCH] arm64: dts: Add L2 cache node to msm8916
In-Reply-To: <1452297429-6382-1-git-send-email-sboyd@codeaurora.org>
References: <1452297429-6382-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160109044130.GA20052@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 03:57:09PM -0800, Stephen Boyd wrote:
> The msm8916 SoC has an L2 cache for all 4 CPUs. Add it to the
> dtsi file so that the cache hierarchy can be probed.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Reviewed-by: Andy Gross <andy.gross@linaro.org>
