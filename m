From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 25 Oct 2011 11:43:39 +1030
Subject: [PATCH v4] virtio: Add platform bus driver for memory mapped
	virtio device
In-Reply-To: <1319461623-16420-1-git-send-email-pawel.moll@arm.com>
References: <1319461560.3668.16.camel@hornet.cambridge.arm.com>
	<1319461623-16420-1-git-send-email-pawel.moll@arm.com>
Message-ID: <87pqhlq3ek.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2011 14:07:03 +0100, Pawel Moll <pawel.moll@arm.com> wrote:
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

Applied.

Thanks!
Rusty.
