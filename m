From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 1 Jun 2017 10:07:19 +0200
Subject: [PATCH v5 00/20] eeprom: at24: Add OF device ID table
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
Message-ID: <CABxcv=kC0Bfxsm73x9AY6OiQCEZOafidMT+kv=qUqpqnaMAMaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Tue, May 23, 2017 at 3:34 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> This series is a follow-up to patch [0] that added an OF device ID table
> to the at24 EEPROM driver. As you suggested [1], this version instead of
> adding entries for every used <vendor,device> tuple, only adds a single
> entry for each chip type using the "atmel" vendor as a generic fallback.
>
> The first patch documents in the DT binding what's the correct vendor to
> use and what are the ones that are being deprecated. The second one adds
> the OF device ID table for the at24 driver and the next patches use this
> vendor in the compatible string to each DTS that defines a compatible I2C
> EEPROM device node.
>
> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.
>
> [0]: https://lkml.org/lkml/2017/3/14/589
> [1]: https://lkml.org/lkml/2017/3/15/99
>

Any comments on this series?

Best regards,
Javier
