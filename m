From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 14:52:13 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Make sound support modular
In-Reply-To: <1432891299-22892-1-git-send-email-geert@linux-m68k.org>
References: <1432891299-22892-1-git-send-email-geert@linux-m68k.org>
Message-ID: <4071593.HlWFN9GR5x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 11:21:38 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Make sound support modular to reduce kernel size (-571 KiB):
> 
>        text    data     bss     dec     hex   filename
>     12990441 1438820  342552 14771813  e16665 vmlinux.before
>     12451039 1396476  339800 14187315  d87b33 vmlinux.after
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

Very nice, thanks a lot!

I've applied both patches to next/defconfig.

	Arnd
