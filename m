From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 01 Jan 2014 17:44:11 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHNwaTogY2xwczcxMXg6IERyaXZlciByZWZhY3Rv?=
 =?UTF-8?B?cg==?=
In-Reply-To: <20140101132334.GP31886@sirena.org.uk>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <20140101132334.GP31886@sirena.org.uk>
Message-ID: <1388583851.810843204@f301.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Wed, Jan 01, 2014 at 10:09:28AM +0400, Alexander Shiyan wrote:
> > This is a complex patch for refactoring CLPS711X SPI driver.
> > Major changes:
> > - Eliminate <mach/hardware.h> usage.
> > - Devicetree support.
> 
> This really needs to be broken up into smaller changes so it can be
> reviewed, your summary would be good as the cover mail for a patch
> series but not for a single commit.  We need one change per commit with
> a clear commit message saying what's going on.
> 
> There's a large set of changes here with no explanation of most of them
> which means I can't really tell if the changes are doing what they're
> supposed to and at least some of them seem to be doing things beyond
> either description above.  I'd expect at least two changes, one for the
> mach/hardware.h elimination and one for the bindings, but probably each
> of those should be split into several changes.  For example the bindings
> changes might have some patches doing refactorings before adding the
> actual bindings.

I wrote that this is a complex patch. This is not a fix, but new driver,
many things are done differently.
I do not see a way to separate these changes.
As an alternative, I can create patch to remove current driver,
then re-adding new one.  Will be more convenient to watch. Is it better? 
Thanks.

---
