From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 11 Sep 2012 21:36:59 +0200
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <87vcfkuz4x.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the pxa include directories

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
