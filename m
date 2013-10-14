From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 14 Oct 2013 18:50:48 +0200
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525C0F99.8030909@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com> <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
 <525BF089.9050408@arm.com> <2CDDB541-0E92-4452-831E-0B29B24A7C89@suse.de>
 <525BF656.7020207@arm.com> <20131014140527.GB5106@redhat.com>
 <525BFBF9.5010804@arm.com> <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
 <525C0514.5030103@arm.com> <525C0622.8040504@redhat.com>
 <525C09D1.8060103@arm.com> <525C0C21.2070001@redhat.com>
 <525C0F99.8030909@arm.com>
Message-ID: <525C20E8.6080409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 14/10/2013 17:36, Marc Zyngier ha scritto:
>> > 
>> > Devices are fine in QEMU, it's only the "generic" parts (rings) that are
>> > missing AFAICT.
> So if I understand correctly how it works, target endianness is set at
> compile time, and you have a BE specific QEMU?

Yes.  Though as Alex said, this will have to change for PPC
little-endian support.

Paolo
