From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 30 Jun 2010 20:00:26 +0300
Subject: [PATCH] Add support for Vista Silicon i.MX27 Visstrim_M10 board.
In-Reply-To: <1277912661-24065-1-git-send-email-javier.martin@vista-silicon.com>
References: <1277912661-24065-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20100630170025.GD23534@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Jun 30, 2010 at 05:44:21PM +0200, Javier Martin wrote:
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  arch/arm/mach-mx2/Kconfig                          |    8 +
>  arch/arm/mach-mx2/Makefile                         |    1 +
>  arch/arm/mach-mx2/mach-imx27_visstrim_m10.c        |  279 ++++++++++++++++++++

This directory are no more. You should rebase your work on the imx-for-2.6.36 
branch of the imx tree at git://git.pengutronix.de/git/imx/linux-2.6.git

>  .../include/mach/board-imx27_visstrim_m10.h        |   24 ++

Any reason not to fold this file into mach-imx27_visstrim_m10.c?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
