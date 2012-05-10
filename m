From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 10 May 2012 18:23:10 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510092733.GH3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
 <20120510090459.GH2982@b20223-02.ap.freescale.net>
 <20120510092733.GH3908@opensource.wolfsonmicro.com>
Message-ID: <20120510102309.GK2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 10:27:34AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 05:05:00PM +0800, Richard Zhao wrote:
> 
> > devm_pinctrl_get_select_default function is added in below commit which
> > is in pinctrl/for-next.
> 
> Oh, dear.  That's unfortunate, I guess it's not on a branch in pinctl
> which can be pulled separately (this is what I've been doing with things
> like regmap and regulator - creating new interfaces on easily mergeable
> branches)?  Looking at it from the other perspective, what goes wrong if
> we defer this patch?
I prefer to have a non-rebase pinctrl branch. We can not defer pinctrl
patch for all drivers. pinctrl will be so widely used.

Hi Linus,

Could you comment?

Thanks
Richard
