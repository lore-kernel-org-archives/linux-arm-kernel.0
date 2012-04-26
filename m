From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 26 Apr 2012 17:29:06 +0200
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120426152906.GP9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:38 Thu 26 Apr     , Shawn Guo wrote:
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-at91/board-1arm.c         |    1 +
>  arch/arm/mach-at91/board-afeb-9260v1.c  |    1 +
>  arch/arm/mach-at91/board-cam60.c        |    1 +
>  arch/arm/mach-at91/board-carmeva.c      |    1 +
>  arch/arm/mach-at91/board-cpu9krea.c     |    1 +
>  arch/arm/mach-at91/board-cpuat91.c      |    1 +
>  arch/arm/mach-at91/board-csb337.c       |    1 +
>  arch/arm/mach-at91/board-csb637.c       |    1 +
>  arch/arm/mach-at91/board-dt.c           |    1 +
>  arch/arm/mach-at91/board-eb01.c         |    1 +
>  arch/arm/mach-at91/board-eb9200.c       |    1 +
>  arch/arm/mach-at91/board-ecbat91.c      |    1 +
>  arch/arm/mach-at91/board-eco920.c       |    1 +
>  arch/arm/mach-at91/board-flexibity.c    |    1 +
>  arch/arm/mach-at91/board-foxg20.c       |    1 +
>  arch/arm/mach-at91/board-gsia18s.c      |    1 +
>  arch/arm/mach-at91/board-kafa.c         |    1 +
>  arch/arm/mach-at91/board-kb9202.c       |    1 +
>  arch/arm/mach-at91/board-neocore926.c   |    1 +
>  arch/arm/mach-at91/board-pcontrol-g20.c |    1 +
>  arch/arm/mach-at91/board-picotux200.c   |    1 +
>  arch/arm/mach-at91/board-qil-a9260.c    |    1 +
>  arch/arm/mach-at91/board-rm9200dk.c     |    1 +
>  arch/arm/mach-at91/board-rm9200ek.c     |    1 +
>  arch/arm/mach-at91/board-rsi-ews.c      |    1 +
>  arch/arm/mach-at91/board-sam9-l9260.c   |    1 +
>  arch/arm/mach-at91/board-sam9260ek.c    |    1 +
>  arch/arm/mach-at91/board-sam9261ek.c    |    1 +
>  arch/arm/mach-at91/board-sam9263ek.c    |    1 +
>  arch/arm/mach-at91/board-sam9g20ek.c    |    1 +
>  arch/arm/mach-at91/board-sam9m10g45ek.c |    1 +
>  arch/arm/mach-at91/board-sam9rlek.c     |    1 +
>  arch/arm/mach-at91/board-snapper9260.c  |    1 +
>  arch/arm/mach-at91/board-stamp9g20.c    |    1 +
>  arch/arm/mach-at91/board-usb-a926x.c    |    1 +
>  arch/arm/mach-at91/board-yl-9200.c      |    1 +
>  arch/arm/mach-at91/clock.c              |    3 +--
>  arch/arm/mach-at91/generic.h            |    5 +++++
>  arch/arm/mach-at91/setup.c              |    5 +++++
I like it but I think it's more time to put soc init that machine init

Best Regards,
J.
