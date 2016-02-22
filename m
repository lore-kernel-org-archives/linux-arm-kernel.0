From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Feb 2016 11:36:25 +0000
Subject: [PATCH 0/6] ARM: decompressor: several cleanups
In-Reply-To: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160222113625.GC19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 04:31:11PM +0900, Masahiro Yamada wrote:
> Masahiro Yamada (6):
>   ARM: decompressor: drop unneeded assignments to "targets"
>   ARM: decompressor: drop more unneeded assignments to "targets"
>   ARM: decompressor: use clean-files instead of extra-y to clean files
>   ARM: decompressor: drop redundant FORCE in Makefile
>   ARM: decompressor: merge piggy.*.S and simplify Makefile
>   ARM: decompressor: rename suffix_y to compress-y

Most of this looks fine to me, but I've a question about how thoroughly
patch 5 has been tested: iow, do we get correct behaviour if only the
compression method is changed?

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
