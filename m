From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 14 Oct 2013 20:10:22 +0300
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525C20E8.6080409@redhat.com>
References: <525BF656.7020207@arm.com> <20131014140527.GB5106@redhat.com>
 <525BFBF9.5010804@arm.com>
 <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
 <525C0514.5030103@arm.com> <525C0622.8040504@redhat.com>
 <525C09D1.8060103@arm.com> <525C0C21.2070001@redhat.com>
 <525C0F99.8030909@arm.com> <525C20E8.6080409@redhat.com>
Message-ID: <20131014171022.GA13807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 06:50:48PM +0200, Paolo Bonzini wrote:
> Il 14/10/2013 17:36, Marc Zyngier ha scritto:
> >> > 
> >> > Devices are fine in QEMU, it's only the "generic" parts (rings) that are
> >> > missing AFAICT.
> > So if I understand correctly how it works, target endianness is set at
> > compile time, and you have a BE specific QEMU?
> 
> Yes.  Though as Alex said, this will have to change for PPC
> little-endian support.
> 
> Paolo

Or we'll just say that this platform requires virtio 1.0.
