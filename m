From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Jan 2014 19:41:42 +0100
Subject: [PATCH] arm/smp: Make boot_secondary() static
In-Reply-To: <CAMuHMdXoZJEgMXH0K1d5kDs+XSM_KMkigUq+mKYVQezdxZ929g@mail.gmail.com>
References: <1388763959-27491-1-git-send-email-geert@linux-m68k.org>
 <201401031804.34124.arnd@arndb.de>
 <CAMuHMdXoZJEgMXH0K1d5kDs+XSM_KMkigUq+mKYVQezdxZ929g@mail.gmail.com>
Message-ID: <4243977.Rh2PlZQ4Sh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014 19:24:19 Geert Uytterhoeven wrote:
> Fine for me.
> 
> Do you want me to fold this into my patch, or will you apply this on top?
> 
> 

The patch is for Russell anyway, so please fold my change into your
patch, unless he prefers your previous version of course.

	Arnd
