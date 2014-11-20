From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 12:27:11 +0100
Subject: [PATCH RESEND V2] ARM: debug: move StrongARM debug include to
 arch/arm/include/debug
In-Reply-To: <CALT56yOEtt4G-_CzbDMXtWPoZL3ErnY8VrfEV+DyBJGPp_r8YA@mail.gmail.com>
References: <1415258423-17022-1-git-send-email-dbaryshkov@gmail.com>
 <CALT56yOEtt4G-_CzbDMXtWPoZL3ErnY8VrfEV+DyBJGPp_r8YA@mail.gmail.com>
Message-ID: <201411201227.11419.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014, Dmitry Eremin-Solenikov wrote:
> 
> 2014-11-06 10:20 GMT+03:00 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>:
> > StrongARM debug-macro.S is quite standalone thing, depending only on
> > register mappings. Move it to proper place and add Kconfig entry.
> >
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > ---
> > [Changes since V1: keep Kconfig.debug sorted alphabetically]
> >
> >  arch/arm/Kconfig.debug                                         |  9 +++++++++
> >  .../include/mach/debug-macro.S => include/debug/sa1100.S}      | 10 ++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >  rename arch/arm/{mach-sa1100/include/mach/debug-macro.S => include/debug/sa1100.S} (83%)
> 
> Dear Russell,
> 
> Is it ok to merge this patch? Would you like to pick it on your own?
> Would you like
> for Arnd to take it through arm-soc? Would you like for me to throw it
> out (and why)?

I've merged it into the next/soc branch of arm-soc now. Russell,
let me know if you have any objections.

There was a trivial merge conflict that I resolved.

	Arnd
