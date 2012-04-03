From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Apr 2012 11:09:35 -0700
Subject: [PATCH] ARM: OMAP: fix section mismatches in usb-host.c
In-Reply-To: <20120327085426.GI7379@arwen.pp.htv.fi>
References: <1332773470-22800-1-git-send-email-grinberg@compulab.co.il>
 <20120327085426.GI7379@arwen.pp.htv.fi>
Message-ID: <20120403180935.GG8240@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120327 01:57]:
> On Mon, Mar 26, 2012 at 04:51:10PM +0200, Igor Grinberg wrote:
> > Fix the below section mismatch warning and alike:
> > 
> > WARNING: vmlinux.o(.text+0x281d4): Section mismatch in reference from
> > the function setup_ehci_io_mux() to the function
> > .init.text:omap_mux_init_signal()
> > The function setup_ehci_io_mux() references
> > the function __init omap_mux_init_signal().
> > This is often because setup_ehci_io_mux lacks a __init
> > annotation or the annotation of omap_mux_init_signal is wrong.
> > 
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks applying into fixes.

Tony
