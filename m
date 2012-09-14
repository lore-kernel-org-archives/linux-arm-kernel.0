From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 09:33:37 +0000
Subject: [PATCH 1/2] ep93xx: Fix type error warnings in ts72xx build
In-Reply-To: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
References: <1347578654-26483-1-git-send-email-rmallon@gmail.com>
Message-ID: <201209140933.37949.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Ryan Mallon wrote:
> Add IOMEM defines for the TS72xx VIRT_BASE defines to fix type
> conversion warnings.
> 
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
