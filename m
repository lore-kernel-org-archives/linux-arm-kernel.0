From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Jul 2011 02:02:39 -0600 (MDT)
Subject: [PATCH v2 0/8] OMAP2+: hwmod framework fixes
In-Reply-To: <alpine.DEB.2.00.1107060129420.4217@utopia.booyaka.com>
References: <1309553647-14624-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060129420.4217@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1107060201160.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Paul Walmsley wrote:

> On Fri, 1 Jul 2011, Benoit Cousson wrote:
> 
> > Here are the latest bug fixes done on the hwmod framework.
> > There are mainly around wakeup capability added in OMAP4.
> > 
> > The series is based on for_3.1/2_prcm_files_cleanup and tested
> > on OMAP4430 ES2.1 + SDP.
> > 
> > The patches are available here:
> > git://gitorious.org/omap-pm/linux.git for_3.1/3_hwmod_fixes
> 
> Thanks, these all look good to me.  Tony, maybe you can pull these 
> straight from Beno?t's branch?

Eh, never mind... I just realized that this branch is based on one of 
his earlier branches.  So if you pull it, you'll get a bunch of other 
stuff that shouldn't be part of this.

Tony, I'll pick these patches out into a separate topic branch and send a 
new pull request.


- Paul
