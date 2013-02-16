From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 23:15:18 +0000
Subject: [PATCH 01/11] ARM: disable virt_to_bus/virt_to_bus almost
 everywhere
In-Reply-To: <BLU0-SMTP3204E8218EA90D50AB340558A0D0@phx.gbl>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-2-git-send-email-arnd@arndb.de>
 <BLU0-SMTP3204E8218EA90D50AB340558A0D0@phx.gbl>
Message-ID: <201302162315.18551.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Emilio L?pez wrote:

> Small nitpick: Please have a look at the patch subject, I suppose you
> meant something like "virt_to_bus/bus_to_virt" instead of
> "virt_to_bus/virt_to_bus".

Yes, absolutely right, thanks for your attention. The patch is already
applied to a stable branch now, so I would prefer not to rebase it
though. If there is an important reason to change the applied patches,
I will fix this one as well.

	Arnd
