From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 May 2012 10:32:41 +0200
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <201205091440.14587.arnd@arndb.de>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
 <201205091440.14587.arnd@arndb.de>
Message-ID: <4FAB7D29.9000107@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/05/2012 16:40, Arnd Bergmann a ?crit :
> On Wednesday 09 May 2012, Maxime Ripard wrote:
>> Here is another version of the patches to bring ADC driver to Atmel boards.
>> Since last version, here is what changed:
>>   * Rebased on top of staging-next to move out of staging. Had to change to IIO
>>     kfifo buffer along the way.
>>   * Reworked the DT bindings according to Jean-Christophe reviews
>>   * Made various fixes according to reviews
>>   * Support for X5 boards
> 
> What's the reason for providing both DT and non-DT probing in that driver?
> Doesn't it make more sense to just require that everyone who uses this
> device boots using the device tree?

Mostly historical actually.
The first versions were made using only non-DT probing, and then DT was
added, so I didn't remove it.
I've no strong feeling about this however, I believe we can definitely
drop it, moreover if it makes life easier for you to merge it.

I'll send an updated version.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
