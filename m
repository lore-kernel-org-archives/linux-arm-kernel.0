From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 1 Jul 2018 20:05:50 +0200
Subject: [PATCH v2 0/3] Add clock driver for Actions S700 SoC
In-Reply-To: <20180628191805.3722-1-sravanhome@gmail.com>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
Message-ID: <8503ae31-aaf3-e4ba-f385-859a6cd3f8d6@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravannan,

Am 28.06.2018 um 21:18 schrieb Saravanan Sekar:
> Changelog v2:
> Fixed 0 day compilation warning
> Modified existing dts Actions S900 clock bindings common to Actions
> Soc family

Please post v3 without --in-reply-to. It's becoming messy to read.

> This patchset adds clock support for Actions Semi OWL series S700 SoC
> with relevant clock bindings and device tree info. 
> 
> Changed the UART clock using CMU instance and changes are tested in
> cubieboard7

Did you find any better way of testing than my "reboot bootloader" from
preinstalled Android?

In addition to missing Actions Semi you may want to CC Cubietech.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
