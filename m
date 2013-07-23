From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 23 Jul 2013 10:06:26 -0600
Subject: Linux Plumbers ACPI/PM, PCI Microconference
In-Reply-To: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
References: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
Message-ID: <CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 8:21 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
> Linux Plumbers has approved an ACPI/PM, PCI microconference. The
> overview page is here:
>
> http://wiki.linuxplumbersconf.org/2013:pci_subsystem
>
> We would like to start receiving volunteers for presenting topics of
> interest.  There is a lot of activity in these subsystems so please
> respond by submitting presentation or discussion proposals that you
> would be willing to cover for consideration.  You should also feel
> free to submit ideas as proposals that others could cover.

Somebody else privately suggested these ARM/PCI topics:

> -> how it's been cleaned up to be more common across arm-32 machines
> -> dependencies on dtb
> -> future use/dependency(s) on ACPI
> -> hotplug support issues (if any; acpi (host-bridge) vs <whatever ARM uses> ?)

and I'm interested in those as well.  There seems to be a lot of
activity in that area.  In addition, I'm interested in ARM IOMMU
support.  I see drivers/iommu/arm-smmu.c, but it's brand-new and I
haven't looked at it at all.

Bjorn
