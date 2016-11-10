From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 10 Nov 2016 19:56:17 +0200
Subject: [PATCH] ARM: OMAP2+: Remove unused MUSB initialization code
In-Reply-To: <20161110175402.GE27724@atomide.com>
References: <1478799800-27945-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20161110175402.GE27724@atomide.com>
Message-ID: <2624325.4PiB8SBptT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 10 Nov 2016 10:54:02 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [161110 10:43]:
> > With the removal of board-ldp.c and board-rx51.c, the last users of the
> > MUSB initialization board code are gone. Remove it.
> 
> Thanks, I have the same patch already from 3 years ago in omap-for-
> v3.14/omap3-board-removal branch that I'll use.

v3.14 ? That feels like cheating :-)

> Still need to rebase and check few other patches there before reposting them
> all.

Will you get that one in v4.10 ?

> FYI, to avoid duplicate work, the old barnch is at [0].
> 
> Regards,
> 
> Tony
> 
> https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=om
> ap-for-v3.14/omap3-board-removal

-- 
Regards,

Laurent Pinchart
