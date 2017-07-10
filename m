From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 10 Jul 2017 09:47:05 +0200
Subject: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
Message-ID: <CABxcv==J_QwoivZ0PRWMoG-weAp7F-LpEXkBxw_9jwH3ENKjsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Thu, Jun 15, 2017 at 8:54 PM, Javier Martinez Canillas
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

Are you planning to pick this series? It has been in the list for
months and were resent many times...

Best regards,
Javier
