From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 06 Mar 2014 13:10:45 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140306120449.GA29916@mal.justgohome.co.uk>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.8040102@redhat.com>
 <53185FB9.1040308@redhat.com> <20140306120449.GA29916@mal.justgohome.co.uk>
Message-ID: <531865C5.6070502@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 06/03/2014 13:04, Robie Basak ha scritto:
> So, for example, the guest OS might, on bootloader or kernel upgrade,
> completely replace the boot mechanism, dropping the removable path and
> replacing it with a fixed disk arrangement, setting boot variables
> appropriately, and assume that it can reboot and everything will
> continue to work.

It can, but at the same time it had better keep the fallback method 
working, where fixed media are treated like removable ones.

In practice, both Linux distributions and Windows do that.

> This is why I'm suggesting that the specification mandate that the guest
> OS shipped in a "portable disk image" as defined by the spec must not
> make this assumption.

Yeah, that's fine to specify.

Paolo
