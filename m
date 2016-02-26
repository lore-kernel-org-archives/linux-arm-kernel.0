From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 17:25:18 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
In-Reply-To: <56B92660.8060203@uclinux.org>
References: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
 <56B92660.8060203@uclinux.org>
Message-ID: <6605497.i4OUUcPESd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 09:36:00 Greg Ungerer wrote:
> On 09/02/16 00:24, Arnd Bergmann wrote:
> > Clang complains about the __initdata section attribute being in the
> > wrong place in two files of ks8695:
> > 
> > arch/arm/mach-ks8695/cpu.c:37:31: error: '__section__' attribute only applies to functions and global variables
> > arch/arm/mach-ks8695/board-og.c:83:31: error: '__section__' attribute only applies to functions and global variables
> > 
> > This moves the attribute to the correct place.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> 

Applied to next/fixes-non-critical in arm-soc directly.

Thanks,

	Arnd
