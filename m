From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 May 2014 14:15:39 -0700
Subject: [PATCH v2] ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP
In-Reply-To: <1400234457.20342.25.camel@x220>
References: <1400187345.11786.28.camel@x220>
 <20140515231229.GA25523@saruman.home>
 <1400232974.20342.22.camel@x220> <1400234457.20342.25.camel@x220>
Message-ID: <20140516211539.GH12881@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Bolle <pebolle@tiscali.nl> [140516 03:01]:
> Commit 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> apparently required that checks for CONFIG_USB_GADGET_OMAP would be
> replaced with checks for CONFIG_USB_OMAP. Do so now for the remaining
> checks for CONFIG_USB_GADGET_OMAP, even though these checks have
> basically been broken since v3.1.
> 
> And, since we're touching this code, use the IS_ENABLED() macro, so
> things will now (hopefully) also work if USB_OMAP is modular.
> 
> Fixes: 193ab2a60700 ("usb: gadget: allow multiple gadgets to be built")
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> v2: us IS_ENABLED() as Felipe requested. Still untested.

Thanks applying into omap-for-v3.16/board.

Tony
