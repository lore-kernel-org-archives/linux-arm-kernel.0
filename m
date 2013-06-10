From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Jun 2013 16:50:49 +0800
Subject: [PATCH 2/4] ARM: imx: clk-imx6q: per1_bch's parent is wrong
In-Reply-To: <51B57328.404@de.bosch.com>
References: <1370034115-24006-1-git-send-email-b20788@freescale.com>
 <1370034115-24006-2-git-send-email-b20788@freescale.com>
 <20130603012939.GB13970@S2101-09.ap.freescale.net>
 <20130603054655.GA23090@S2101-09.ap.freescale.net>
 <51B57328.404@de.bosch.com>
Message-ID: <20130610085047.GD6381@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 08:33:12AM +0200, Dirk Behme wrote:
> On 03.06.2013 07:46, Shawn Guo wrote:
> >On Mon, Jun 03, 2013 at 09:29:41AM +0800, Shawn Guo wrote:
> >>On Fri, May 31, 2013 at 05:01:53PM -0400, Anson Huang wrote:
> >>>per1_bch is sourced from ahb, previous parent
> >>>info is incorrect.
> >>>
> >>>Signed-off-by: Anson Huang <b20788@freescale.com>
> >>
> >>Applied, thanks.
> >>
> >I just pulled it out.  As Reference Manual does not mention it, we need
> >to confirm with designer about the correct parent of per1_bch.
> 
> Any news on this?

It turns out that the existing code is correct.  So this patch should
just be dropped.

Shawn
