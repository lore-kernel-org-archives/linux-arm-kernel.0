From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 02 Jan 2014 22:20:34 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIHNwaTogY2xwczcxMXg6IERyaXZlciByZWZhY3Rv?=
 =?UTF-8?B?cg==?=
In-Reply-To: <201401021846.23488.arnd@arndb.de>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru>
 <20140101150737.GR31886@sirena.org.uk>
 <201401021846.23488.arnd@arndb.de>
Message-ID: <1388686834.668518989@f215.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wednesday 01 January 2014, Mark Brown wrote:
> > > As an alternative, I can create patch to remove current driver,
> > > then re-adding new one.  Will be more convenient to watch. Is it better? 
> > 
> > No, that's really not good.  It's very rare that we just completely
> > rewrite a driver especially not one that's been around for a while -
> > there needs to be a really good reason for it.  This is a key part of
> > how the development process works, incremental improvements and code
> > review.  Doing this both helps improve quality control on changes and
> > allows collaboration.
> 
> I definitely agree with what you say, but please note that Alexander is
> the only person who ever sends clps711x patches, so there is not much
> hope of collaboration. I also suspect he's the only one who would
> suffer from accidental breakage, especially since the existing driver
> is not used anywhere upstream (no instance of platform data, and no
> DT support).

Thanks for protection Arnd :) 
Indeed, all as you say, of course it does not mean that I got VIP status and
can make any changes to the kernel tree,
make me comments - I'm learning this.

---
