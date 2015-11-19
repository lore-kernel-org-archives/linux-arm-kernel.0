From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2015 00:11:26 +0000
Subject: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Message-ID: <20151119001126.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 03:40:25AM +0800, Chen Gang wrote:
> >From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 2001
> From: Chen Gang <gang.chen.5i5j@gmail.com>
> Date: Thu, 19 Nov 2015 03:24:42 +0800
> Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
> 
> They are not symmetric with each other, neither are used in real world
> (can not be found by grep command in source code root directory), so
> remove them.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

For:
> ?arch/arm/include/asm/page-nommu.h | 3 ---

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
