From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 12 Sep 2012 23:56:52 +0100 (BST)
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <1347490612.68141.YahooMailClassic@web171606.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Tue, 11/9/12, Arnd Bergmann <arnd@arndb.de> wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the pxa include directories

For arch/arm/mach-pxa/hx4700.c:

Acked-by: Paul Parsons <lost.distance@yahoo.com>
