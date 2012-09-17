From: cjb@laptop.org (Chris Ball)
Date: Mon, 17 Sep 2012 03:52:52 -0400
Subject: [PATCH v2 2/3] mmc: davinci_mmc: convert to DMA engine API
In-Reply-To: <k139rl$gbm$2@ger.gmane.org> (Koen Kooi's message of "Wed, 22 Aug
 2012 20:53:43 +0200")
References: <1345574589-24757-1-git-send-email-mporter@ti.com>
 <1345574589-24757-3-git-send-email-mporter@ti.com>
 <k139rl$gbm$2@ger.gmane.org>
Message-ID: <m3ipbdytkb.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 22 2012, Koen Kooi wrote:
> Op 21-08-12 20:43, Matt Porter schreef:
>> Removes use of the DaVinci EDMA private DMA API and replaces it with use
>> of the DMA engine API.
>> 
>> Signed-off-by: Matt Porter <mporter@ti.com>
>
> Runtime tested on hawkboard with 3.6.0-rc2 with rootfs on SD and running
> bonnie++ on it.
>
> Tested-by: Koen Kooi <koen@dominion.thruhere.net>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
