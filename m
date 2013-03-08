From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Mar 2013 10:21:19 +0100
Subject: [PATCH 0/5] pcmcia: at91_cf: clean up and add DT support
In-Reply-To: <1360863766-22511-1-git-send-email-manabian@gmail.com>
References: <1360863766-22511-1-git-send-email-manabian@gmail.com>
Message-ID: <5139AD8F.2060607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 06:42 PM, Joachim Eastwood :
> Hi
> 
> This series clean up at91_cf a bit and add DT bindings.
> 
> Patch series tested on custom RM9200 board in both with DT and
> with old platform data.
> 
> 
> Joachim Eastwood (5):
>   pcmcia: at91_cf: fix gpio_get_value in at91_cf_get_status
>   pcmcia: at91_cf: convert to dev_ print functions
>   pcmcia: at91_cf: use devm_ functions for allocations
>   pcmcia: at91_cf: clean up header includes
>   pcmcia: at91_cf: add support for DT
> 
>  .../devicetree/bindings/ata/atmel-at91_cf.txt      |  19 +++
>  drivers/pcmcia/Kconfig                             |   2 +-
>  drivers/pcmcia/at91_cf.c                           | 148 +++++++++++----------
>  3 files changed, 99 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt

Joachim,

Thanks a lot for these patches. You can add on the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I hope that it can be taken by linux-pcmcia.

Best regards,

PS: make sure to add linux-arm-kernel mailing-list as well: it always
interests people there to have updates on AT91 peripherals...
-- 
Nicolas Ferre
