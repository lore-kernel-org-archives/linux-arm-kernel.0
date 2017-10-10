From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Oct 2017 11:58:50 +0200
Subject: [PATCH 1/2] dt-bindings: add binding for Allwinner R40 SATA AHCI
 controller
In-Reply-To: <20171008043541.48564-1-icenowy@aosc.io>
References: <20171008043541.48564-1-icenowy@aosc.io>
Message-ID: <20171010095850.nyu3oljrz6frpeom@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 08, 2017 at 04:35:40AM +0000, Icenowy Zheng wrote:
> The Allwinner R40 SoC contains a SATA AHCI controller like the one in
> A10/A20 SoCs, however a reset control and two power supplies are added
> to it.
> 
> Add a binding document for it.
> 
> As a dedicated binding document is needed now for the A10/A20/R40 AHCI
> controller, drop the A10 compatible line from generic platform AHCI
> controller binding document.

Why is it needed?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171010/8bd79095/attachment-0001.sig>
