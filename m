From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Aug 2015 16:52:36 +0100
Subject: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries
 for qspi
In-Reply-To: <55BEF5D1.1050608@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-5-git-send-email-vigneshr@ti.com>
 <20150731181903.GN20873@sirena.org.uk> <55BEF5D1.1050608@ti.com>
Message-ID: <20150804155236.GS20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 10:32:09AM +0530, Vignesh R wrote:
> On 07/31/2015 11:49 PM, Mark Brown wrote:

> >> -			reg = <0x47900000 0x100>;
> >> +			reg = <0x47900000 0x100>,
> >> +			      <0x30000000 0x3ffffff>;
> >> +			reg-names = "qspi_base", "qspi_mmap";

> > The DT binding document for the controller needs to be extended to
> > document this change in the binding.

> DT bindings are already documented at
> Documentation/devicetree/bindings/spi/ti_qspi.txt. Did you mean to add
> this node as an example in that file?

No, I mean you're changing the binding to add this new memory region -
that new region needs to be added to the documentation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/9f6981ad/attachment.sig>
