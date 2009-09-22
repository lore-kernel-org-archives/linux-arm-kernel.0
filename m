From: andy@warmcat.com (Andy Green)
Date: Tue, 22 Sep 2009 15:10:00 +0100
Subject: SPI, DMA and an i.MX31
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E03@tesla.star.galaxy.io>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>	<4AB7C020.2070205@gmail.com><4AB839FF.4000803@windriver.com><87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>	<4AB8C1A4.4020403@warmcat.com>
	<87077C4F48609F4392621D9F99DDE20901202E03@tesla.star.galaxy.io>
Message-ID: <4AB8DAB8.801@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/09 14:22, Somebody in the thread at some point said:

Hi Rene -

> After changing that my system booted smoothly. If I look in '/proc' there
> is a dir called 'sdma', and inside there is a file 'channels':
> $ cat channels
> Channel 0: MCU
>
> It seams to be alive :-)
>
>> Take a look at ./drivers/mmc/host/mxcmmc.c
>
> Next will try to test the mmc driver, but I don't have an MMC/SD slot on
> my board. Hopefully there is some sign of an MMC in the channels
> file or so.

Sounds encouraging... if you want to post or send a test patch if it 
gets to that point I'll try to give it a go on a real SD Card.

At the moment event/0 which owns the PIO to the SD card eats most of the 
CPU on a loaded system, this should be pretty revolutionary when it works.

-Andy
