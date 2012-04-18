From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Apr 2012 11:45:43 +0100
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <201204180806.16848.arnd@arndb.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <20120417205001.GH6498@mwanda> <201204180806.16848.arnd@arndb.de>
Message-ID: <20120418104543.GH3021@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 08:06:16AM +0000, Arnd Bergmann wrote:
> On Tuesday 17 April 2012, Dan Carpenter wrote:

> > This probably applies fine (the previous version did a couple days
> > ago), but it's always best to submit patches against linux-next.
> > The 3.4 kernel is in -rc already so this is 3.5 material.

> I disagree. The patches won't get applied on -next, they get applied
> on an -rc release, so they should be submitted against that version
> as well. I agree that it makes sense to test patches against -next
> when there is reason to believe there might be conflicts, but it's
> not mandatory. When you know about conflicts against other patches
> that are already in -next, I suggest listing them in the cover 
> letter (the patch 0/x) and suggest a resolution.

Dan's advice is generally sensible for most subsystems - it's not so
much that you should submit against -next itself but rather that you
should be checking what you're submitting against the latest versions of
the subsystems to make sure that you're up to date with the latest APIs
and best practices.  -next is (or should be) a good proxy for this.

If you know the relevant subsystem and driver are pretty stable then
it's generally not going to be an issue to just use the -rcs but there's
enough areas where there's rapid development of one form or another it's
likely to save you at least one round trip of "that's nice but needs
some updates because it won't apply/won't build/isn't using this new
feature we want to convert everyone to" that it's a good default to
check with -next first.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/3b1c0685/attachment.sig>
