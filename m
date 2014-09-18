From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Sep 2014 08:57:32 -0700
Subject: [PATCH 08/12] ARM: omap2plus_defconfig: Shrink with savedefconfig
In-Reply-To: <20140916045603.GA10498@saruman.home>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
 <1410837126-31553-8-git-send-email-tony@atomide.com>
 <20140916045603.GA10498@saruman.home>
Message-ID: <20140918155731.GC14505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140915 21:57]:
> Hi,
> 
> On Mon, Sep 15, 2014 at 08:12:02PM -0700, Tony Lindgren wrote:
> > This saves few lines and makes it easier to make patches
> > against omap2plus_defconfig.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> while at that, can you enable voluntary preemption ?

OK, can you do a separate patch for that with a brief description
why it should be enabled?

Regards,

Tony
