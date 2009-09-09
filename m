From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 09 Sep 2009 07:49:00 -0700
Subject: [patch for 2.6.31] zaurus c3000 aka spitz: fix resume
In-Reply-To: <20090909075024.GA1400@ucw.cz>
References: <20090909075024.GA1400@ucw.cz>
Message-ID: <1252507740.14793.115.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-09 at 09:50 +0200, Pavel Machek wrote:
> Hi, Linus!
> 
> Spitz resume was broken for year or likely two, and it would be very
> nice to fix it for 2.6.31 release. One liner is below, and it really
> can not harm. It already is in Eric's fix queue, so pulling that for
> .31 should work, too.
> 
> Do you think you could take it?

One checkpatch error here..

ERROR: trailing whitespace
#77: FILE: arch/arm/mach-pxa/sharpsl_pm.c:681:
+^Iif ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || $

total: 1 errors, 0 warnings, 10 lines checked


Daniel
