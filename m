From: andy.tang@nxp.com (Andy Tang)
Date: Thu, 1 Jun 2017 08:34:24 +0000
Subject: [PATCH 2/2 v2] clk: qoriq: Separate root input clock for core
 PLLs on ls1012a
In-Reply-To: <20170601082804.GE20170@codeaurora.org>
References: <1489977443-33582-1-git-send-email-andy.tang@nxp.com>
 <1489977443-33582-2-git-send-email-andy.tang@nxp.com>
 <20170601082804.GE20170@codeaurora.org>
Message-ID: <HE1PR0402MB282824858F29C431E97DBF07F3F60@HE1PR0402MB2828.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your applying.

There are other two patches sent on April 6, 2017:
https://patchwork.kernel.org/patch/9665973/
https://patchwork.kernel.org/patch/9665977/

Hope they are in your review queue. Please give it a review.

Regards,
Andy

-----Original Message-----
From: Stephen Boyd [mailto:sboyd at codeaurora.org] 
Sent: Thursday, June 01, 2017 4:28 PM
To: Andy Tang <andy.tang@nxp.com>
Cc: mturquette at baylibre.com; robh+dt at kernel.org; mark.rutland at arm.com; linux-clk at vger.kernel.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Scott Wood <oss@buserror.net>
Subject: Re: [PATCH 2/2 v2] clk: qoriq: Separate root input clock for core PLLs on ls1012a

On 03/20, Yuantian Tang wrote:
> From: Scott Wood <oss@buserror.net>
> 
> ls1012a has separate input root clocks for core PLLs versus the 
> platform PLL, with the latter described as sysclk in the hw docs.
> If a second input clock, named "coreclk", is present, this clock will 
> be used for the core PLLs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
