From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Nov 2011 11:26:31 -0700
Subject: [PATCH v2] arm: omap: Fix errors and warnings when building
	for one board
In-Reply-To: <E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com>
References: <1318522450-18425-1-git-send-email-premi@ti.com>
	<E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com>
Message-ID: <20111103182631.GT31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Premi, Sanjeev <premi@ti.com> [111028 06:36]:
> > -----Original Message-----
> > From: Premi, Sanjeev 
> > Sent: Thursday, October 13, 2011 9:44 PM
> > To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Cc: Premi, Sanjeev
> > Subject: [PATCH v2] arm: omap: Fix errors and warnings when 
> > building for one board
> > 
> > When customizing omap2plus_defconfig to build for only
> > one board (omap3evm), I came across these warnings and
> > errors (filenames truncated):
> 
> Just wanted to check the status of this patch.

Thanks, now with the DT patches merged, I'll apply this into fixes.
Also moved around the ifdef a little to avoid a build warning for
when omap3 is not selected.

Regards,

Tony
