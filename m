From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 08:46:24 +0100
Subject: Pre-merge-window status of the arm-soc tree
In-Reply-To: <201203062054.55434.arnd@arndb.de>
References: <201203062054.55434.arnd@arndb.de>
Message-ID: <20120307074624.GH21255@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Notably absent here are still mach-msm and mach-shmobile and some
> platforms have more patches pending. If you have anything that you
> want to get included in 3.4, then now would be a good time to send
> that. Anything that is not in arm-soc by the time the merge window
> opens is not going to make it into the release, and you should allow
> a little bit of time to sort out any conflicts between sending pull
> requests and having them in the branch.
I've much more to send to pull for AT91 DT but all depends on 2 patches
acked by not pulled so far for of

Grant can I apply it via AT91 (of boolean support and nand generic binding)
as I need them for
NAND
USB device
I2C
Shutdown Controller support
RAM Controller
Reset Controller
USB Host

Best Regards,
J.
