From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Jun 2016 16:12:22 +0000
Subject: [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
In-Reply-To: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160627161222.GY9922@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Alexandre,

On Mon, Jun 27, 2016 at 12:03:02AM +0200, Alexandre Belloni wrote:
> m48t86.h belongs to include/linux/platform_data/
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> 
>  arch/arm/mach-ep93xx/ts72xx.c                          | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c                   | 2 +-
>  drivers/rtc/rtc-m48t86.c                               | 2 +-
>  include/linux/{m48t86.h => platform_data/rtc-m48t86.h} | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)

For the orion5x bit,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
