From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 15:11:05 +0200
Subject: [PATCH 14/16] ARM: orion: move platform_data definitions
In-Reply-To: <1347368559-31329-2-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-1-git-send-email-arnd@arndb.de>
 <1347368559-31329-2-git-send-email-arnd@arndb.de>
Message-ID: <20120911151105.2178cde9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Le Tue, 11 Sep 2012 15:02:37 +0200,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the orion include directories

I have already posted patches for this during the ARM summit, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/116380.html.

They have been applied by the Marvell maintainer Jason Cooper and are
scheduled for 3.7, see
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/116432.html.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
