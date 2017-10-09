From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Oct 2017 16:06:47 +0100
Subject: [PATCH 1/3] ARM: add KBUILD_ prefix to CFLAGS_MODULE,
 LDFLAGS_MODULE
In-Reply-To: <1507559715-30918-2-git-send-email-yamada.masahiro@socionext.com>
References: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
 <1507559715-30918-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171009150647.GU20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 11:35:13PM +0900, Masahiro Yamada wrote:
> {CFLAGS,LDFLAGS}_MODULE are supposed to be set by users, not by
> in-kernel makefiles.
> 
> Documentation/kbuild/makefiles.txt clearly explains the difference:
> 
>   KBUILD_CFLAGS_MODULE   Options for $(CC) when building modules
> 
>       $(KBUILD_CFLAGS_MODULE) is used to add arch-specific options that
>       are used for $(CC).
>       From commandline CFLAGS_MODULE shall be used (see kbuild.txt).
> 
>   KBUILD_LDFLAGS_MODULE   Options for $(LD) when linking modules
> 
>       $(KBUILD_LDFLAGS_MODULE) is used to add arch-specific options
>       used when linking modules. This is often a linker script.
>       From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
