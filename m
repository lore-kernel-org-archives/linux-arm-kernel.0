From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Sep 2012 15:30:16 +0000
Subject: [PATCH] ARM: mvebu: fix build breaks from multi-platform
 conversion
In-Reply-To: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
References: <1348758612-27012-1-git-send-email-robherring2@gmail.com>
Message-ID: <201209271530.17243.arnd@arndb.de>
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

Acked-by: Arnd Bergmann <arnd@arndb.de>

I actually had the same patch since monday but haven't managed to
send out my series.

Olof probably has a better idea of how to apply this than me
to avoid further merge conflicts.

	Arnd
