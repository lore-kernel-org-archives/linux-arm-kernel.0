From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Oct 2018 16:15:33 +0100
Subject: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
In-Reply-To: <20181009110210.i6xphyuy5jkcfaug@katana>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009110210.i6xphyuy5jkcfaug@katana>
Message-ID: <20181009151533.GC20774@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 01:02:10PM +0200, Wolfram Sang wrote:

> We recently had this discussion in I2C world about using the parent if
> the (logical) device has a NULL fw_node [1]. I don't know if the other
> subsystems you modify use logical devices as well? If no, it seems we
> need an additional check for the parent in the I2C core only. If yes,
> this might be considered in your patchset?

SPI has a logical controller device as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181009/93d2a7ff/attachment-0001.sig>
