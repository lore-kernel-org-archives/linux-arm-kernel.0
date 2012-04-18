From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 18 Apr 2012 12:36:04 +0300
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <201204180806.16848.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <20120417205001.GH6498@mwanda> <201204180806.16848.arnd@arndb.de>
Message-ID: <20120418093604.GL6498@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 08:06:16AM +0000, Arnd Bergmann wrote:
> On Tuesday 17 April 2012, Dan Carpenter wrote:
> > On Tue, Apr 17, 2012 at 07:08:19PM +0200, Roland Stigge wrote:
> > > Applies to v3.4-rc3
> > > 
> > 
> > This probably applies fine (the previous version did a couple days
> > ago), but it's always best to submit patches against linux-next.
> > The 3.4 kernel is in -rc already so this is 3.5 material.
> 
> I disagree. The patches won't get applied on -next, they get applied
> on an -rc release, so they should be submitted against that version
> as well. I agree that it makes sense to test patches against -next
> when there is reason to believe there might be conflicts, but it's
> not mandatory. When you know about conflicts against other patches
> that are already in -next, I suggest listing them in the cover 
> letter (the patch 0/x) and suggest a resolution.
> 

I'm not sure I understand.  I thought everyone used the develop
against linux-next and backport the fixes model.  Are we going to
try merge these in 3.4?  It will still spend some time in linux-next
before we submit it, right?

To be honest, I mostly am familiar with staging/ where driver wide
white space cleanups are the norm.  Working against linux-next is
the only option for us or otherwise the conflicts would be too
much.

regards,
dan carpenter
