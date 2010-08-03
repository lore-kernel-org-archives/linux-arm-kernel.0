From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Aug 2010 10:22:11 +0300
Subject: [PATCH] OMAP2: powerdomain: Add break in switch statement
In-Reply-To: <alpine.DEB.2.00.1007121418220.10106@utopia.booyaka.com>
References: <1278661253-22185-1-git-send-email-weber@corscience.de>
	<alpine.DEB.2.00.1007121418220.10106@utopia.booyaka.com>
Message-ID: <20100803072210.GQ12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [100712 23:14]:
> On Fri, 9 Jul 2010, Thomas Weber wrote:
> 
> > Add a missing break at end of switch statement. At the moment it is a
> > fall through to WARN_ON(1) and return -EEXIST.
> > 
> > Signed-off-by: Thomas Weber <weber@corscience.de>
> 
> Thanks Thomas.
> 
> Tony, this is
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> if you want it for .36; otherwise, can queue it for .37 here.

Thanks, I've added it into omap-for-linus.

Regards,

Tony
