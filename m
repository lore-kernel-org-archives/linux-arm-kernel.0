From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 09:33:54 +0000
Subject: [PATCH 2/2] ep93xx: Move ts72xx.h out of include/mach
In-Reply-To: <1347578654-26483-2-git-send-email-rmallon@gmail.com>
References: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
 <1347578654-26483-2-git-send-email-rmallon@gmail.com>
Message-ID: <201209140933.54890.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Ryan Mallon wrote:
> The ts72xx.h header is only included by arch/arm/mach-ep93xx/ts72xx.c.
> It therefore does not need to be in the globally exported include/mach
> directory. Move it to to arch/arm/mach-ep93xx.
> 
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
