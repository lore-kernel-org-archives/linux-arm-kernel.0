From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 17 Nov 2015 22:30:19 +0100 (CET)
Subject: [PATCH v4 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <1447790576-29410-3-git-send-email-ariel@vanguardiasur.com.ar>
References: <1447790576-29410-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1447790576-29410-3-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <1326700858.341668.1447795819246.JavaMail.open-xchange@oxbaltgw05.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ariel D'Alessandro <ariel@vanguardiasur.com.ar> hat am 17. November 2015 um
> 21:02 geschrieben:
>
>
> This commit adds support for NXP LPC18xx EEPROM memory found in NXP
> LPC185x/3x and LPC435x/3x/2x/1x devices.
>
> EEPROM size is 16384 bytes and it can be entirely read and
> written/erased with 1 word (4 bytes) granularity. The last page
> (128 bytes) contains the EEPROM initialization data and is not writable.
>
> Erase/program time is less than 3ms. The EEPROM device requires a
> ~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
> the system bus clock by the division factor, contained in the divider
> register (minus 1 encoded).
>
> EEPROM will be kept in Power Down mode except during read/write calls.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Btw Rob Herring acked [PATCH v3 1/4] yesterday.
