From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 17 Mar 2013 14:01:23 -0700
Subject: [PATCH 3.9-rc1] clk: vt8500: Fix variable name '*prate' compile
 error
In-Reply-To: <201303112207.32619.arnd@arndb.de>
References: <1361900052-66917-1-git-send-email-tim.gardner@canonical.com>
 <20130226192958.14870.54664@quantum> <201303112207.32619.arnd@arndb.de>
Message-ID: <20130317210123.8663.84457@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2013-03-11 15:07:32)
> On Tuesday 26 February 2013, Mike Turquette wrote:
> > Quoting Tim Gardner (2013-02-26 09:34:12)
> > > commit 72480014b86c8b51fb51c5c6a0525876055c37c7 (clk: vt8500: Fix device clock
> > > divisor calculations) introduced a compile error in the naming of a variable in
> > > vt8500_dclk_set_rate(). It looks like a simple cut and paste error.
> > > 
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> > 
> > Tim,
> > 
> > Thanks for the fix.  I already have a fix for this issue in my clk-fixes
> > branch.  In fact I forgot to bundle this one and another mxs fix in my
> > 3.9 pull request so I'll send a follow-up bugfix branch after 3.9-rc1 is
> > out.
> > 
> 
> It seems this hasn't happened yet. I also don't see the patch in linux-next.
> Is this patch still on your radar?
> 

Arnd,

Yes it is.  I haven't pushed a new branch out since 3.9-rc1 due to LCE
and vacation after that.  This fix and other pending patches will get
pulled in this week.

Regards,
Mike

>         Arnd
