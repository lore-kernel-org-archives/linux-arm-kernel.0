From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 8 Jan 2018 14:45:48 +0000
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180104162036.GL3401@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
Message-ID: <20180108144548.GA31502@xora-haswell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 05:20:36PM +0100, Andrew Lunn wrote:
> > > I already agreed with 'reg' being awkward in the later emails.
> > > Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
> > > 
> > Ah it is an actual address, then yes _ADR is probably more appropriate.
> 
> Newbie ACPI question. What is the definition of an address?
> 
> In this cause, we are talking about an address of a device on an MDIO
> bus. It takes a value between 0 and 31.
> 
> How are IC2 device addresses represented in ACPI? MDIO devices and I2C
> devices are pretty similar. So it would make sense to use the same as
> what I2C uses.
> 
Too big (and has table) to sensibly quote, but defined in ACPI spec

6.1.1 _ADR (Address)

Ive never though been quite sure if that is just an example list of
address types or its supposed to be canonical (in which case some ECRs
are needed to the spec).

Thanks

Graeme

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/3ef4716e/attachment.sig>
