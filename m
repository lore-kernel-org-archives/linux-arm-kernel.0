From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 12 Jun 2018 14:29:36 +1000
Subject: [PATCH] usb/gadget: aspeed-vhub: add USB_LIBCOMPOSITE dependency
In-Reply-To: <87o9gxcono.fsf@linux.intel.com>
References: <20180525160729.92026-1-arnd@arndb.de>
 <87o9gxcono.fsf@linux.intel.com>
Message-ID: <71cfc192be06d07e79bfdfe43a566d3260e19cd6.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-30 at 15:29 +0300, Felipe Balbi wrote:
> Hi,
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > Without that option, we run into a link failure:
> > 
> > drivers/usb/gadget/udc/aspeed-vhub/hub.o: In function `ast_vhub_std_hub_request':
> > hub.c:(.text+0x5b0): undefined reference to `usb_gadget_get_string'
> > 
> > Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Greg, can you send this to Linus asap ? Some people are hitting build
breakages upstream because of this.

Thanks !

Cheers,
Ben,
