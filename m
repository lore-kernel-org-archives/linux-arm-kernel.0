From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 15:34:27 +0200
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <6153646.CZ57BgYKf3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 06:32:10 Kukjin Kim wrote:
> This series removes S5P64X0 and S5PC100 related codes in mainline,
> because no more user now. And if its supporting is required later,
> it will be done with using device tree.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Your patch 1/17 has not made it to the mailing list, it's probably too
large. Can you try recreating the patch using 'git format-patch -D'?

I'd like to see the changes to arch/arm/plat-samsung.

	Arnd
