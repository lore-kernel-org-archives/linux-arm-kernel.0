From: frieder.schrempf@exceet.de (Frieder Schrempf)
Date: Thu, 2 Aug 2018 12:46:36 +0200
Subject: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180802101742.GF9117@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk> <20180801215733.4dfa3a95@bbrezillon>
 <20180802101742.GF9117@sirena.org.uk>
Message-ID: <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02.08.2018 12:17, Mark Brown wrote:
> On Wed, Aug 01, 2018 at 09:57:33PM +0200, Boris Brezillon wrote:
>> Mark Brown <broonie@kernel.org> wrote:
> 
>> 2/ Getting this patch [1] merged and implementing the ->get_name() hook
>>     in this driver so that SPI NOR devs declared to the MTD layer keep
>>     the same name after the transition to spi-mem and mtdparts= passed on
>>     the cmdline keep working. Without this in place we're likely to
>>     break a few setups :-/.
> 
>> [1]https://patchwork.kernel.org/patch/10508693/
> 
> I don't seem to have a copy of this patch...  not sure it was sent to
> me?

When I sent the patch I put you in cc. So if nothing went wrong you 
should have it.
It is part of the SPI MEM conversion series for the FSL QSPI driver [1].

Boris made some remarks on documentation in v2, that I have fixed, but 
not sent out yet, as we have some blocking issues with the driver itself.

So if you want I could send the patch separately so it can be applied 
with the Atmel driver.

Regards,
Frieder

[1] https://patchwork.ozlabs.org/cover/939864/
