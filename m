From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 30 Sep 2012 12:00:42 +0000
Subject: [PATCH] arm: vt8500: Fixup for missing gpio.h
In-Reply-To: <20120929211805.GF12999@quad.lixom.net>
References: <1348595239-30577-1-git-send-email-linux@prisktech.co.nz>
 <1348595239-30577-2-git-send-email-linux@prisktech.co.nz>
 <20120929211805.GF12999@quad.lixom.net>
Message-ID: <201209301200.43031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 September 2012, Olof Johansson wrote:
> By the way, I noticed that there is no VT8500 defconfig in the tree, so there's
> no easy way for us to check for build breakages of your platform. You might
> want to add one.

I suppose if Tony and the other vt8500 developers manage to get the platform
enabled for CONFIG_MULTIPLATFORM in 3.8, we can simply enable it in a future
multi_v5_defconfig and don't even need the specific one.

On the other hand, those systems are fairly resource limited, so maybe
we want to do both after all.

	Arnd
