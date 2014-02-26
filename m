From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 26 Feb 2014 20:20:52 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <530E4C39.9010804@redhat.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <530E4C39.9010804@redhat.com>
Message-ID: <CAFEAcA_ojkfaud3QGc7MA=2DRvcynsPz9F9yZ7MxmqENzpQz9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2014 20:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 26/02/2014 20:55, Arnd Bergmann ha scritto:
>> Did you notice we are removing mach-virt now? Probably no point
>> mentioning it here.
>
>
> Peter, do we still want mach-virt support in QEMU then?

Yes, it will be about the only thing that supports PCI-e :-)
When the kernel guys say "removing mach-virt" they mean
removing a specific lump of kernel code, not removing support
for having a kernel that can handle a machine described
only by the device tree.

thanks
-- PMM
