From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 20:32:02 +0000
Subject: [PATCH] ARM: mvebu: fix build breaks from multi-platform
 conversion
In-Reply-To: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
References: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
Message-ID: <201209282032.03004.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 September 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Moving ARCH_MVEBU for multi-platform support caused several breakages in
> recently added addr-map and pinctrl support for mvebu. This adds the
> necessary selects and include paths to fix the build.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>

Applied on top of the late/kirkwood branch that introduced the incorrect
merge.

	Arnd
