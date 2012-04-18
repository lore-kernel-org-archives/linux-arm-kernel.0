From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 08:06:16 +0000
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <20120417205001.GH6498@mwanda>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <20120417205001.GH6498@mwanda>
Message-ID: <201204180806.16848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Dan Carpenter wrote:
> On Tue, Apr 17, 2012 at 07:08:19PM +0200, Roland Stigge wrote:
> > Applies to v3.4-rc3
> > 
> 
> This probably applies fine (the previous version did a couple days
> ago), but it's always best to submit patches against linux-next.
> The 3.4 kernel is in -rc already so this is 3.5 material.

I disagree. The patches won't get applied on -next, they get applied
on an -rc release, so they should be submitted against that version
as well. I agree that it makes sense to test patches against -next
when there is reason to believe there might be conflicts, but it's
not mandatory. When you know about conflicts against other patches
that are already in -next, I suggest listing them in the cover 
letter (the patch 0/x) and suggest a resolution.

	Arnd
