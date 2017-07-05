From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Jul 2017 13:33:04 +0100
Subject: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
In-Reply-To: <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
 <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
Message-ID: <20170705123304.extc5iswhwjepwyp@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 01:59:55AM +0200, Mason wrote:

> Do larger SoC vendors have HW devs working closely with
> Linux devs, to avoid these design bloopers?

Yes, or just internal software teams in general - hardware designs tend
to be a lot more usable if there's good dialogue with users about what's
useful and what isn't.  It's going to happen at some point anyway when
people can't get the chip working well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170705/c86058d6/attachment-0001.sig>
