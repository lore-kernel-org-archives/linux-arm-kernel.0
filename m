From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 28 Jun 2018 11:53:15 +0200
Subject: [PATCH 0/4] RDU1/2 latest supported RAVE SP nodes
In-Reply-To: <20180628042424.12664-1-andrew.smirnov@gmail.com>
References: <20180628042424.12664-1-andrew.smirnov@gmail.com>
Message-ID: <1530179595.22468.50.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.06.2018, 21:24 -0700 schrieb Andrey Smirnov:
> Shawn:
> 
> These are patches adding the rest of RAVE SP child nodes covering all
> the rest of currently supported MFD cells. There's more to be added,
> once more drivers get accepted upstream.
> 
> The bindings three drivers mentioned are availible in:
> 
> ????Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
> ????Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
> ????Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
> 
> Feedback is welcome!

Apart from the RDU 1/2 mixup you noticed yourself this looks good to
me. Maybe Shawn can just fix this up while applying.

For the series:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas
