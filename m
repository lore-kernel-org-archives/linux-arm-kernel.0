From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 11 Jun 2012 09:58:29 +1000
Subject: [PATCH] arm: ep93xx: Enable i2c support for ep9302
In-Reply-To: <alpine.LFD.2.00.1206101542100.21012@FC9.localdomain>
References: <alpine.LFD.2.00.1206101542100.21012@FC9.localdomain>
Message-ID: <4FD534A5.1030301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/12 22:44, Todor Colov wrote:

> 
> Enable i2c support for ep9302. i2c support is needed when external RTC is 
> used. 
> 
> Signed-off-by: Todor Colov <todorcolov@gmail.com>

Thanks. Applied to ep93xx-fixes.

> --- linux-3.4/arch/arm/mach-ep93xx/edb93xx.c	2012-05-21 01:29:13.000000000 +0300
> +++ linux-3.4/arch/arm/mach-ep93xx/edb93xx-i2c-ep9302-enabled.c	2012-06-10 14:18:06.977893546 +0300


Please use git diff in future. This wouldn't directly apply with git am.

~Ryan
