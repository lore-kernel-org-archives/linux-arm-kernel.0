From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Mar 2012 11:05:01 -0700
Subject: [PATCH 4/8] ARM: OMAP1: Move 16xx GPIO system clock to
 platform init code
In-Reply-To: <20120312173005.A11093E07B0@localhost>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234042.18709.57610.stgit@kaulin.local>
 <20120312173005.A11093E07B0@localhost>
Message-ID: <20120312180500.GJ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [120312 10:32]:
> On Tue, 21 Feb 2012 15:40:42 -0800, Tony Lindgren <tony@atomide.com> wrote:
> > This way we can remove omap_read/write call from the GPIO driver
> > and remove include to linux/io.h.
> > 
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Who will be picking up this series?  How intertwined is it with your tree Tony?

Thanks for following up on this, no need to do anything on this.

This popped up few weeks ago and was resolved by pulling your GPIO
branch into arm-soc. For more info, please see:

Subject: linux-next: manual merge of the arm-soc tree with the gpio tree

http://lkml.org/lkml/2012/3/1/7

Regards,

Tony
