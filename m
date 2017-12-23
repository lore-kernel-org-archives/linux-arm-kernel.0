From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 23 Dec 2017 12:37:18 +0800
Subject: [PATCH RESEND 1/1] cpufreq: imx6q: switch to Use clk_bulk_get to
 refine clk operations
In-Reply-To: <2124437.LcYqgt3btA@aspire.rjw.lan>
References: <1504179837-18842-1-git-send-email-aisheng.dong@nxp.com>
 <20170914214032.GE11836@ubuntu>
 <20171221131733.GA24403@b29396-OptiPlex-7040>
 <2124437.LcYqgt3btA@aspire.rjw.lan>
Message-ID: <20171223043718.GB32736@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 07:34:57PM +0100, Rafael J. Wysocki wrote:
> On Thursday, December 21, 2017 2:18:01 PM CET Dong Aisheng wrote:
> > Hi Rafael,
> > 
> > On Thu, Sep 14, 2017 at 02:40:32PM -0700, Viresh Kumar wrote:
> > > On 31-08-17, 19:43, Dong Aisheng wrote:
> > > > Use clk_bulk_get to ease the driver clocks handling.
> > > > 
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Anson Huang <anson.huang@nxp.com>
> > > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > --
> > > > The original one is here which depends on clk_bulk APIs.
> > > > https://patchwork.kernel.org/patch/9737337/
> > > > Now the clk_bulk APIs are already in kernel, so resend the patch.
> > > > (Patch title changed a bit to be more specific.)
> > > > ---
> > > >  drivers/cpufreq/imx6q-cpufreq.c | 125 ++++++++++++++++++----------------------
> > > >  1 file changed, 56 insertions(+), 69 deletions(-)
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > 
> > 
> > Would you help pick it?
> > I did not see it in latest kernel.
> > It still applies.
> 
> OK
> 
> Can you please resend the patch again with the ACK from Viresh?
> 

Of course yes.

Thanks

Regards
Dong Aisheng

> It looks like it fell through the cracks, sorry about that.
> 
> Thanks,
> Rafael
> 
