From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 16 Oct 2015 08:44:00 +0200
Subject: [PATCH 3/3] ARM: at91/defconfig: update sama5 defconfig
In-Reply-To: <561FC97D.2040806@atmel.com>
References: <1444824684-24526-1-git-send-email-ludovic.desroches@atmel.com>
 <1444824684-24526-3-git-send-email-ludovic.desroches@atmel.com>
 <20151015132451.GD3421@piout.net>
 <20151015153116.GE26893@odux.rfo.atmel.com>
 <561FC97D.2040806@atmel.com>
Message-ID: <20151016064400.GH26893@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 05:42:53PM +0200, Nicolas Ferre wrote:
> Le 15/10/2015 17:31, Ludovic Desroches a ?crit :
> > On Thu, Oct 15, 2015 at 03:24:51PM +0200, Alexandre Belloni wrote:
> >> Hi,
> >>
> >> On 14/10/2015 at 14:11:24 +0200, Ludovic Desroches wrote :
> >>> Add SAMA5D2 SoC plus Atmel flexcom and Atmel sdhci devices.
> >>>
> >>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>> ---
> >>>  arch/arm/configs/sama5_defconfig | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >> It is probably worth updating the multi_v7_defconfig too (in a separate
> >> patch).
> >>
> > 
> > Maybe I have to send a whole defconfig update . I mean when you do
> > savedefconfig, you have more changes. I won't send each one separately. I
> > have kept changes which were in relation with the stuff I had.
> > 
> > Or I can send a defconfig update from the savedefconfig and then add
> > sama5d2, flexcom and sdhci.
> 
> Actually you can do this for our own AT91 defconfigs.
> 
> For the multi_v7_defconfig I would recommend to simply make a patch with
> our updates and let the arm-soc maintainer merge it with their current
> one: I mean, they will manage the conflicts on this file anyway and the
> changes to this file will not be part of one or our pull-requests but a
> patch that they will handle separately: so no need to add more update
> than the strictly needed ones on our end.
> 

In fact, I realize that I have read too quickly Alexandre's answer. I
have understood that I should put CONFIG_SOC_SAM_V7=y in a separate
patch.

So yes I would do a whole update for our defconfigs and only the
addition needed for the multi_v7 one

Ludovic
