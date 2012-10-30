From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 30 Oct 2012 16:01:13 +0100
Subject: [PATCH] mmc: at91-mci: remove driver
In-Reply-To: <87625txrou.fsf@octavius.laptop.org>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
 <87625txrou.fsf@octavius.laptop.org>
Message-ID: <20121030150113.GB19021@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:45 Mon 29 Oct     , Chris Ball wrote:
> Hi,
> 
> On Mon, Oct 29 2012, ludovic.desroches at atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> > The at91-mci driver is no more needed since atmel-mci driver supports
> > all Atmel devices.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Thanks!  Pushed to mmc-next for 3.8.
if you don't mind I prefer to take it via at91

I've a patch series that cleanup the platform_data it's difficult to merge
with this one

Best Regards,
J.
