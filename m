From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2016 10:58:06 -0700
Subject: [PATCH] ARM: OMAP2+: Remove unused MUSB initialization code
In-Reply-To: <2624325.4PiB8SBptT@avalon>
References: <1478799800-27945-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161110175402.GE27724@atomide.com> <2624325.4PiB8SBptT@avalon>
Message-ID: <20161110175806.GG27724@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [161110 10:56]:
> Hi Tony,
> 
> On Thursday 10 Nov 2016 10:54:02 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [161110 10:43]:
> > > With the removal of board-ldp.c and board-rx51.c, the last users of the
> > > MUSB initialization board code are gone. Remove it.
> > 
> > Thanks, I have the same patch already from 3 years ago in omap-for-
> > v3.14/omap3-board-removal branch that I'll use.
> 
> v3.14 ? That feels like cheating :-)

:p

> > Still need to rebase and check few other patches there before reposting them
> > all.
> 
> Will you get that one in v4.10 ?

Yeah planning to assuming no problems and when out
of the eternal musb regressions land.

Regards,

Tony
