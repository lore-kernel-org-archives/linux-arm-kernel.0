From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 May 2012 20:39:54 -0300
Subject: [PATCH 2/3] ARM: mx28: Add SPI resources
In-Reply-To: <loom.20120528T090703-293@post.gmane.org>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-2-git-send-email-festevam@gmail.com>
 <loom.20120528T090703-293@post.gmane.org>
Message-ID: <CAOMZO5Ch+q=Sk2_a_ZdVo3PvLCTPVvniEw07o6by8nHw_swQ5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Paul,

On Mon, May 28, 2012 at 4:25 AM, Jean-Paul <alainsergenagni@yahoo.com> wrote:
>
> Hi Fabio Estevam,
> ?I have im28 evk board and I fallowed your instructions to add the SPI resources
> in my kernel. I'm using the kernel 3.2.15. After rebuilding the kernel, I still
> can not see the imx28 spi drivers. Im sorry to ask these beginner questions but
> I'm new in using linux spi drivers.

On patch 3/3 I added the support for a SPI NOR flash.

> ?I checked at these locations:
> ? ? /sys/class/spidev ? and ? ?/sys/class/spi_master
> I could not see any SPI device, it was just empty.
>
> when I do: ls /sys/bus/spi/drivers
> I can see: ? enc28j60 , mc33880 , mmc_spi , and spidev
>
> How can I create a device spi node since it looks like that i don't have spi
> driver for the imx28 evk board?

Make sure you added the mxs spi driver I posted in the spi list and
also that you selected it in .config.

I still need to add dt support for the mxs spi driver.

Regards,

Fabio Estevam
