From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 24 Jan 2013 14:42:36 +0000
Subject: [kvmarm] [Qemu-devel] [RFC] Virtio-desktop: Virtio-based virtual
 desktop
In-Reply-To: <EC4021BD-DDB7-4D28-BD79-4B7A809200AE@suse.de>
References: <CALrVBktEQM5D-L+60RTzdRgo7jLZ671KxWMUFGnQwQ1bzgjO2A@mail.gmail.com>
 <20130124092531.GD18072@stefanha-thinkpad.redhat.com>
 <EC4021BD-DDB7-4D28-BD79-4B7A809200AE@suse.de>
Message-ID: <CAFEAcA-EM-aj-tMZbfhbLg20OB0iBk7qnTRuYav0PBaRNTsXXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 January 2013 14:38, Alexander Graf <agraf@suse.de> wrote:
> But check out the QEMU e500 machine. We have a fully device tree
> based machine type in the kernel. QEMU drives it by generating a
> device tree for devices it actually exposes on the fly.

The ARM equivalent for that would be mach-virt, I think
(I forget what the status is but no doubt somebody will
remind me :-))

> The big advantage we have here is that
>
>   1) We don't have to emulate all hardware real hardware emulates
>   2) We're not restricted to emulate what real hardware emulates. PCI on ARM anyone?

...do we have an ARM PCI controller of any working kind in
the kernel? versatilepb's PCI controller doesn't count as
it is utterly broken :-)

-- PMM
