From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Feb 2014 13:07:31 +0100
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <20140220112248.GC32456@localhost>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
 <20140220112248.GC32456@localhost>
Message-ID: <116078520.5VTDQYu7BE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 February 2014 11:22:48 Catalin Marinas wrote:
> 
> I'm fine with this. Do we still need something for ARMv8 server
> platforms like ARCH_ARM_SBSA? The only advantage would be to make it
> easier for mobile targeted kernel builds to disable server features but
> I'm not sure there are so many such features, people can trim the
> .config manually.

I think in particular for SBSA compliant platforms we should not
have per-platform options at all the way we do for embedded,
as they will be much more homogenous.

> Two additional points:
> 
> 1. Single arm64 defconfig file covering everything
> 2. Modules rather than built-in by default where possible (especially
>    for server platforms)

+1

	Arnd
