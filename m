From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Feb 2016 12:18:05 +0000
Subject: [PATCH 0/6] ARM: decompressor: several cleanups
In-Reply-To: <CAK7LNAQEwm=2bHX+kTxFVJTh-sFX+3MBgwuEmmNM-XoyvdbWRA@mail.gmail.com>
References: <1456126277-14633-1-git-send-email-yamada.masahiro@socionext.com>
 <20160222113625.GC19428@n2100.arm.linux.org.uk>
 <CAK7LNAQEwm=2bHX+kTxFVJTh-sFX+3MBgwuEmmNM-XoyvdbWRA@mail.gmail.com>
Message-ID: <20160222121805.GD19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:08:05PM +0900, Masahiro Yamada wrote:
> I did build-test, changing the configuration
> CONFIG_KERNEL_GZIP -> CONFIG_KERNEL_LZMA -> CONFIG_KERNEL_XZ -> ...
> 
> I confirmed zImage was created from the expected piggy.
> 
> For run-test, it worked fine too.

Okay, please drop them into the patch system, thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
