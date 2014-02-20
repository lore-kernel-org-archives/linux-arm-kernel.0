From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 20 Feb 2014 18:26:49 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392896356.23342.40.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
 <1392896356.23342.40.camel@kazak.uk.xensource.com>
Message-ID: <20140220232649.GU7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:39:16AM +0000, Ian Campbell wrote:
> On Thu, 2014-02-20 at 11:19 +0000, Russell King - ARM Linux wrote:
> > What's wrong with the soc subsystem (drivers/base/soc.c).  This
> > provides a way to export SoC through standardised interfaces. 
> 
> It looks like the thing to use to me.
> 
> It seems to have been around only since v3.3 though, which makes it a
> bit tricky to use when upgrading from running board-file based v3.2
> system (Debian Wheezy) to a newer DTB based kernel, we need to select
> the new DTB while running the old system.
> 
> I'd prefer to use this thing as the primary mechanism but it seems like
> I'd have to implement some sort of fallback at least for one Debian
> release cycle. I'm sure it is doable...

back in v3.2, lspci should still work.  Would that given you the
information you need?

thx,

Jason.
