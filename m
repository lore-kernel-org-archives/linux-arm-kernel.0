From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 10 Sep 2012 10:32:26 -0700
Subject: [PATCH v2 1/4] clk: add of_clk_src_onecell_get() support
In-Reply-To: <20120910062535.GU26709@S2101-09.ap.freescale.net>
References: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
 <1345642590-29905-2-git-send-email-shawn.guo@linaro.org>
 <20120831064125.GA3271@r65073-Latitude-D630>
 <20120906221155.20289.73650@nucleus>
 <20120907002618.GB26709@S2101-09.ap.freescale.net>
 <20120907192444.20289.97042@nucleus>
 <20120910062535.GU26709@S2101-09.ap.freescale.net>
Message-ID: <20120910173226.20289.88000@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2012-09-09 23:25:43)
> On Fri, Sep 07, 2012 at 12:24:44PM -0700, Mike Turquette wrote:
> > Done.  I've taken patch #1 "clk: add of_clk_src_onecell_get() support"
> > into clk-next.
> > 
> Thanks, Mike.
> 
> I'm still waiting for a stable branch like clk-3.7, which I can ask
> arm-soc folks to pull as a dependency.  I have some imx and mxs 3.7
> material currently pending on this.
> 

Hi Shawn,

I didn't realize you were waiting on a stable branch.  It seemed that no
one used my clk-3.6 stable branch during the last cycle so I got lazy
and decided not to have a clk-3.7 this time around.  However my current
clk-next HEAD is stable so creating one is easy enough... done!

Now that I have a clk-3.7 stable branch I'll plan on merging clk-next
into clk-3.7 periodically as stability dictates.

Arnd, how does the "arm-soc dependency" thing work?  Do I still issue a
pull request to Linus for 3.7?

Regards,
Mike

> -- 
> Regards,
> Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
