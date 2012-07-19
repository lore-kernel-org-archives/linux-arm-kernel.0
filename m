From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jul 2012 00:00:58 +0800
Subject: [PATCH] PM / OPP: Initialize OPP table from device tree
In-Reply-To: <201207182136.43507.rjw@sisk.pl>
References: <1342630669-27546-1-git-send-email-shawn.guo@linaro.org>
 <201207182136.43507.rjw@sisk.pl>
Message-ID: <20120719160055.GA30461@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Wed, Jul 18, 2012 at 09:36:43PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 18, 2012, Shawn Guo wrote:
> > With a lot of devices booting from device tree nowadays, it requires
> > that OPP table can be initialized from device tree.  The patch adds
> > a helper function of_init_opp_table together with a binding doc for
> > that purpose.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> While I can take it, I'm not going to include it into my v3.6 pull request.
> 
> If no one has objections, it will show up in linux-next after v3.6-rc1.
> 
I have a cpufreq patch depending on this one.  Since you are maintaining
cpufreq too, I just had them be a series below and sent them all to you.

  [PATCH 0/3] Add a generic cpufreq-cpu0 driver

Regards,
Shawn
