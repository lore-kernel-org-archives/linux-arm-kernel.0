From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 09 Nov 2011 21:30:40 +0100
Subject: CONFIG_USB_GADGET_PXA27X
Message-ID: <1320870640.27598.33.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Commit 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b ("usb: gadget: allow
multiple gadgets to be built") dropped config USB_GADGET_PXA27X. But
currently there are still five references to CONFIG_USB_GADGET_PXA27X
(all in arch/arm/mach-pxa).

1) A naive fix would be to simply replace CONFIG_USB_GADGET_PXA27X with
CONFIG_USB_PXA27X everywhere (and change CONFIG_USB_GADGET_PXA27X_MODULE
likewise). Would that be correct?


Paul Bolle
