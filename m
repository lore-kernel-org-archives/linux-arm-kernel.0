From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 13 Oct 2011 17:49:54 +0100
Subject: [PATCH v3] virtio: Add platform bus driver for memory mapped
	virtio device
In-Reply-To: <1317919843-8343-1-git-send-email-pawel.moll@arm.com>
References: <1317841030-17758-1-git-send-email-pawel.moll@arm.com>
	<1317919843-8343-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1318524594.3216.119.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

On Thu, 2011-10-06 at 17:50 +0100, Pawel Moll wrote:
> This patch, based on virtio PCI driver, adds support for memory
> mapped (platform) virtio device. This should allow environments
> like qemu to use virtio-based block & network devices even on
> platforms without PCI support.
> 
> One can define and register a platform device which resources
> will describe memory mapped control registers and "mailbox"
> interrupt. Such device can be also instantiated using the Device
> Tree node with compatible property equal "virtio,mmio".
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Anthony Liguori <aliguori@us.ibm.com>
> Cc: Michael S.Tsirkin <mst@redhat.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Does the silence mean that everyone is happy about the code and the
spec? ;-) Does it look good enough for the imminent 3.2 merge window?

Cheers!

Pawel
