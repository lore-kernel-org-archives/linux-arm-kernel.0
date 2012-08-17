From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Aug 2012 08:52:12 +0800
Subject: [PATCH v3 2/3] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <201208162305.55114.rjw@sisk.pl>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-3-git-send-email-shawn.guo@linaro.org>
 <201208162305.55114.rjw@sisk.pl>
Message-ID: <20120817005210.GD24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 11:05:54PM +0200, Rafael J. Wysocki wrote:
> On Friday, August 10, 2012, Shawn Guo wrote:
> > With a lot of devices booting from device tree nowadays, it requires
> > that OPP table can be initialized from device tree.  The patch adds
> > a helper function of_init_opp_table together with a binding doc for
> > that purpose.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I need an ACK from whoever maintains the DT bindings for that.
> 
Rob, please?

-- 
Regards,
Shawn
