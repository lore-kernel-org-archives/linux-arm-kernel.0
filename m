From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 14 Oct 2013 15:29:26 +0200
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525BF089.9050408@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com> <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
 <525BF089.9050408@arm.com>
Message-ID: <525BF1B6.5050206@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 14/10/2013 15:24, Marc Zyngier ha scritto:
> See my initial patch for that:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-October/007359.html
> 
> That doesn't really change the non-trapping virtio accesses, though.
> Where is this virtio_is_big_endian() thing?

In QEMU.

Paolo
