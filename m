From: marex@denx.de (Marek Vasut)
Date: Tue, 11 Sep 2012 21:13:01 +0200
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <201209112113.02181.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the pxa include directories
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[...]

Nice list ;-)

For the Palm part, Balloon3 part, Colibri part, Vpac part, Z2 part:

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
