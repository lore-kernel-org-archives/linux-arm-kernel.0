From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 13 Sep 2011 09:58:42 +0100
Subject: [RFC v2] arm: Add platform bus driver for virtio device
In-Reply-To: <4E6E40EC.9040200@us.ibm.com>
References: <1315845956.3297.7.camel@hornet.cambridge.arm.com>
	<1315846301-13892-1-git-send-email-pawel.moll@arm.com>
	<4E6E40EC.9040200@us.ibm.com>
Message-ID: <1315904322.3297.11.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-09-12 at 12:27 -0500, Anthony Liguori wrote:
> > This patch, based on virtio PCI driver, adds support for memory
> > mapped (platform) virtio  device. This should allow environments
> > like qemu to use virtio-based block&  network devices.
>
> Are you planning on sending patches to QEMU for this?  I think it makes 
> sense to start in QEMU with this effort and make a proper spec from 
> which you can write the driver against.

Even better :-) Peter Maydell (Linaro QEMU magician) agreed to do this
himself, once we reach some agreement regarding the interface.

Cheers!

Pawe?
