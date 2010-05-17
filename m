From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Mon, 17 May 2010 09:33:21 +0100
Subject: Anyone knows abot the DMA status on the PB1176JZF-S baseboard?
In-Reply-To: <AANLkTim4Y5vkPYUWSNigIL72-f9jfTLq-nEKD_apaD0p@mail.gmail.com>
References: <AANLkTim4Y5vkPYUWSNigIL72-f9jfTLq-nEKD_apaD0p@mail.gmail.com>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA42DA36A9C40@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij
> Sent: 15 May 2010 01:37

Note that Bahadir doesn't work for ARM anymore.

> I got hold of a baseboard for ARM RealView Versatile 1176JZF-S.
>
> However in the manual that comes with the board the DMA PL081
> controller is listed but in recent manuals it has been removed.
> It's device entry was commented out in
> arch/arm/mach-realview/realview_pb1176.c
> when the support was submitted.
>
> When I test it, the hardware is there and responding at
> the listed address. However it doesn't seem to work so well,
> all kind of odd behaviour... Like loosing bits on the bus.
>
> Is the PL081 instance in the PB1176 known to be broken and is that
> the reason for it being removed from the manual?

Early images did include DMA support but it was found to be broken and was removed from later images and from the documentation.

Regards,
Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
