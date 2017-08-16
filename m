From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Aug 2017 16:21:11 +0200
Subject: [RESEND PATCH v5 03/16] ARM: dts: efm32: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170615185418.13980-4-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-4-javier@dowhile0.org>
Message-ID: <CABxcv=nqWgpGaypYn8JMSfjOP8zbRPKOM2Ye-6zRwNhcH0hKcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 8:54 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> The at24 driver allows to register I2C EEPROM chips using different vendor
> and devices, but the I2C subsystem does not take the vendor into account
> when matching using the I2C table since it only has device entries.
>
> But when matching using an OF table, both the vendor and device has to be
> taken into account so the driver defines only a set of compatible strings
> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>
> So add this generic fallback to the device node compatible string to make
> the device to match the driver using the OF device ID table.
>
> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>

Any comment on this?

Wolfram, maybe you can ack the pending DTS patches so I can post them
to the arm-soc maintainers directly for they to pick them?

Best regards,
Javier
