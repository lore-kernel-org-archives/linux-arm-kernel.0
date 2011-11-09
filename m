From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Nov 2011 09:20:11 +0800
Subject: Broken imx_v4_v5_defconfig on 3.2-rc1
In-Reply-To: <CAOMZO5BuC5CvY=K=OPVB3pA39u2ASua8OrxMMvoW04wg3V4qng@mail.gmail.com>
References: <CAOMZO5BuC5CvY=K=OPVB3pA39u2ASua8OrxMMvoW04wg3V4qng@mail.gmail.com>
Message-ID: <20111109012010.GA7579@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 10:32:51PM -0200, Fabio Estevam wrote:
> When building  imx_v4_v5_defconfig on 3.2-rc1:
> 
>   CC      arch/arm/plat-mxc/irq-common.o
>   CC      arch/arm/plat-mxc/avic.o
> arch/arm/plat-mxc/avic.c:155: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before 'avic_handle_irq'
> make[1]: *** [arch/arm/plat-mxc/avic.o] Error 1
> make: *** [arch/arm/plat-mxc] Error 2
> 
> BTW, too bad that no i.MX can be built on 3.2-rc1
> 
http://www.spinics.net/lists/arm-kernel/msg146437.html

Unfortunately, this pull request did not catch -rc1.

-- 
Regards,
Shawn
