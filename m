From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 12:11:19 +0000
Subject: [PATCH v4 05/11] ep93xx: Convert the watchdog driver into a
 platform device.
In-Reply-To: <1331592502-9083-6-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-6-git-send-email-rmallon@gmail.com>
Message-ID: <201203131211.19422.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Ryan Mallon wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> Convert the ep93xx watchdog driver into a platform device and
> remove it's dependency on <mach/hardware.h>.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that you have an extra From: line in the beginning.

	Arnd
