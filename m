From: balbi@ti.com (Felipe Balbi)
Date: Thu, 10 Nov 2011 00:01:45 +0200
Subject: CONFIG_USB_GADGET_PXA27X
In-Reply-To: <1320870640.27598.33.camel@x61.thuisdomein>
References: <1320870640.27598.33.camel@x61.thuisdomein>
Message-ID: <20111109220144.GA17605@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 09, 2011 at 09:30:40PM +0100, Paul Bolle wrote:
> 0) Commit 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b ("usb: gadget: allow
> multiple gadgets to be built") dropped config USB_GADGET_PXA27X. But
> currently there are still five references to CONFIG_USB_GADGET_PXA27X
> (all in arch/arm/mach-pxa).
> 
> 1) A naive fix would be to simply replace CONFIG_USB_GADGET_PXA27X with
> CONFIG_USB_PXA27X everywhere (and change CONFIG_USB_GADGET_PXA27X_MODULE
> likewise). Would that be correct?

Eric, any comments ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111110/33f6ef7d/attachment.sig>
