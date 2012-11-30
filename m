From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Nov 2012 09:58:08 -0800
Subject: [PATCH] ARM: sunxi: add missing include for mdelay()
In-Reply-To: <50B86BCA.7050103@free-electrons.com>
References: <20121130013730.GA30592@beefymiracle.amer.corp.natinst.com>
 <50B86BCA.7050103@free-electrons.com>
Message-ID: <20121130175808.GA4505@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 09:18:18AM +0100, Maxime Ripard wrote:
> Le 30/11/2012 02:37, Josh Cartwright a ?crit :
> >   CC      arch/arm/mach-sunxi/sunxi.o
> > ./arch/arm/mach-sunxi/sunxi.c: In function 'sunxi_restart':
> > ./arch/arm/mach-sunxi/sunxi.c:55:3: error: implicit declaration of function 'mdelay' [-Werror=implicit-function-declaration]
> > 
> > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 

Thanks, applied on top of sunxi/soc2.


-Olof
