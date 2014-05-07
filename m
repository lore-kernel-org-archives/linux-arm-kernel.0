From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 May 2014 15:07:07 -0700
Subject: [PATCH 02/26] ARM: OMAP: dmtimer: Add comments on OMAP1 clock
 framework
In-Reply-To: <536AAA31.6080905@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
 <1398375849-6017-3-git-send-email-joelf@ti.com>
 <20140507152004.GC9502@atomide.com> <536AAA31.6080905@ti.com>
Message-ID: <20140507220706.GD19102@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [140507 14:49]:
> On 05/07/2014 10:20 AM, Tony Lindgren wrote:
> > * Joel Fernandes <joelf@ti.com> [140424 14:44]:
> >> OMAP1 doesn't support clock framework, add a comment where needed
> >> and correct a FIXME.
> > 
> > This is at least a wrong comment, the original comment seems right
> > to me.
> 
> Can you elaborate a bit more please on the wrongness of the comment?
> 
> I can change the comment to say "common clock" instead of "clock" if
> that's the only problem here.

The original comment is just fine, no need to patch it. We do have
clock framework support for omap1, it was the first ever Linux
clock framework that pretty much all other clock frameworks are
based on. Just drop this patch it's misleading.

Regards,

Tony
