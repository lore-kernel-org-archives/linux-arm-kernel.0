From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 09:53:28 -0500
Subject: [RFC/PATCH-v4.2-rc6 4/5] arm: omap2: timer: simplify
 omap4_local_timer_init()
In-Reply-To: <20150812071424.GO4215@atomide.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-5-git-send-email-balbi@ti.com>
 <20150812071424.GO4215@atomide.com>
Message-ID: <20150812145328.GC13884@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:14:24AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > all users of omap4_local_timer_init() are already
> > DT-only, so we can remove the check for having
> > DTB or not.
> > 
> > While at that, fix a typo in comment.
> 
> We already have d1dabab2841d ("ARM: OMAP2+: Clean up
> omap4_local_timer_init") in Linux next reviewed-by you :)

hehe, I had forgotten about that sorry. I'll rebase this on today's
next and resend the series. I'll also test $subject without the other
patches.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/68c7e75a/attachment.sig>
