From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 May 2013 17:24:48 -0700
Subject: [PATCH 00/14] ARM: OMAP5: hwmod, prm/cm data files and updates
 for 3.11
In-Reply-To: <20130530001321.GR13507@atomide.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <20130530001321.GR13507@atomide.com>
Message-ID: <20130530002447.GS13507@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130529 17:19]:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [130529 09:44]:
> > Tony, Paul,
> > 
> > Here is another attempt to send the SOC data files for OMAP5 based devices.
> > As aligned on list, I have dropped clock data from the series.
> > That means for the boot, one clock data patch needs to be applied.
> > It is available on my git tree in 'out_of_tree/omap5_clk_data' branch.
> > 
> > With OMAP5 and AM33XX support is DT only, respective hwmod files are cleaned
> > up to remove iospace information and un-used hwmod. For 3.11 since OMAP4
> > is also targeted as DT only, its hwmod data files is also cleaned up.
> > Diffstat looks something like below.
> > 
> > 27 files changed, 9013 insertions(+), 2764 deletions(-)
> > 
> > One can easily notice that the OMAP5 SOC data has significantly come down
> > becasue of iospace and rest of the hwmod clean-up.
> 
> Yes that's great. I'd like to take the last three patches into my yet to
> be posted omap-for-v3.11/cleanup branch with the omap4 legacy boot files
> now that -rc3 is out and the GPIO fix dependency has cleared.
> 
> Paul, care to ack those three? Then you probably want to review queue
> the rest I presume.

Correction: The last two patches I mean.

Regards,

Tony
