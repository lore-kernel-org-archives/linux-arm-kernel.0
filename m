From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 12:11:46 +0000
Subject: [PATCH v4 06/11] ep93xx: Move peripheral defines to local SoC
 header
In-Reply-To: <1331592502-9083-7-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-7-git-send-email-rmallon@gmail.com>
Message-ID: <201203131211.46289.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Ryan Mallon wrote:
> Move the AHB/APB peripheral defines to local SoC header since they are
> only needed by the core SoC code. The UART defines are not moved
> because they are used by the mach/uncompress.h header.
> 
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>
> Acked-by: Hartley Sweeten <hsweeten@visionengravers.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
