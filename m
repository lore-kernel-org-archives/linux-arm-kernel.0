From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 16 Apr 2012 09:40:11 +0200
Subject: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
In-Reply-To: <4F7F2220.50003@interlog.com>
References: <20120315180835.2e669111@endymion.delvare>
 <20120331081927.2438ea9e@endymion.delvare> <4F7CD11C.2090801@interlog.com>
 <20120405092422.453edecf@endymion.delvare> <4F7E3267.9040306@interlog.com>
 <20120406083751.46fd23c5@endymion.delvare> <4F7F16D3.6080307@interlog.com>
 <20120406182534.68d7f53d@endymion.delvare> <4F7F2220.50003@interlog.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A1D2@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Douglas Gilbert wrote on 2012-04-06:
> On 12-04-06 12:25 PM, Jean Delvare wrote:
>> On Fri, 06 Apr 2012 12:16:19 -0400, Douglas Gilbert wrote:
>>> However I see that Nikolaus Voss has submitted a replacement driver
>>> for the i2c-at91 that works for the G45 which has two TWI units.
>>> Is that driver going into the mainline? Surely it is much better
>>> than the broken i2c-at91 driver that has been sitting broken for
>>> way too long. Atmel are bringing out new MCUs in that family which
>>> have 3 TWI units (e.g. AT91SAM9G25). Apart from the limitations
>>> about repeated starts surely Atmel have fixed the problems referred
>>> to in existing mainline i2c-at91.c driver from circa 2006.
>>> 
>>> My vote would be to add Nikolaus Voss's driver ASAP.
>> 
>> I'm not into embedded devices, so this isn't my call.
> 
> A pity. I checked lk 3.4-rc1 and the bad old driver is still there.

as I see it, my driver has only been tested with the G45. If you
can confirm it works with other devices, too, maybe this would help
to get it into next.

Niko
