From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 07 Sep 2012 12:24:44 -0700
Subject: [PATCH v2 1/4] clk: add of_clk_src_onecell_get() support
In-Reply-To: <20120907002618.GB26709@S2101-09.ap.freescale.net>
References: <1345642590-29905-1-git-send-email-shawn.guo@linaro.org>
 <1345642590-29905-2-git-send-email-shawn.guo@linaro.org>
 <20120831064125.GA3271@r65073-Latitude-D630>
 <20120906221155.20289.73650@nucleus>
 <20120907002618.GB26709@S2101-09.ap.freescale.net>
Message-ID: <20120907192444.20289.97042@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2012-09-06 17:26:20)
> On Thu, Sep 06, 2012 at 03:11:55PM -0700, Mike Turquette wrote:
> > Quoting Shawn Guo (2012-08-30 23:41:27)
> > > Ping, Mike.
> > > 
> > 
> > Hi Shawn,
> > 
> > Do you want me to take everything including patch #2?  I'm OK with the
> > series but want to make sure it won't cause too much problem for you if
> > the DTS and arch/arm changes go through my tree.
> > 
> It will cause conflicts to have those arch/arm changes to go through
> your tree, so I expect you only take patch #1 and ensure your branch
> is stable.  I will ask arm-soc people to pull in your branch as
> dependency, and then I can have other patches go via arm-soc tree.
> 

Done.  I've taken patch #1 "clk: add of_clk_src_onecell_get() support"
into clk-next.

Thanks,
Mike

> -- 
> Regards,
> Shawn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
