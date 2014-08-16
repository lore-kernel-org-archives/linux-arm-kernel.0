From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 15:59:54 +0100
Subject: [PATCH v3] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <1406552704-6736-1-git-send-email-afaerber@suse.de>
References: <1406552704-6736-1-git-send-email-afaerber@suse.de>
Message-ID: <20140816145954.GS28623@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 03:05:03PM +0200, Andreas F?rber wrote:
> The specification requires compatible = "adi,axi-spdif-1.00.a" but
> driver and example and file name indicate "adi,axi-spdif-tx-1.00.a".
> Change the specification to match the implementation.

Applied, let me once again remind you to use commit logs that match the
general style for the subsystem so that it is clear what you are trying
to change and the changelogs look nice.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/cd2dd373/attachment.sig>
