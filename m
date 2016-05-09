From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:27:40 +0200
Subject: [GIT PULL v2 4/4]: ARM: tegra: Enable the XUSB controller
In-Reply-To: <1461946410-24940-1-git-send-email-thierry.reding@gmail.com>
References: <1461945149-23686-5-git-send-email-thierry.reding@gmail.com>
 <1461946410-24940-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <4193084.2p7bAmYgJ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 18:13:30 Thierry Reding wrote:
> ARM: tegra: Enable the XUSB controller
> 
> These changes add support for the XUSB controller on Tegra124. It is an
> XHCI compatible controller that replaces the existing EHCI controllers.
> Support is enabled on Venice2, Jetson TK1 and Nyan-based Chromebooks.
> 

I have merged branches 1, 2, and 3 into next/drivers, and then again
into next/late, with this one on top. We will probably send the late
branch at the same time as the others, but this keeps the dependency
sorted out. Thanks,

	Arnd
