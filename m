From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 22 Jul 2014 10:08:54 -0600
Subject: [PATCH v4] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CA+mB=1JupzQy+R14kKAk7mTJR2FcZ+cQv-uXQSB6jEVBW95aGQ@mail.gmail.com>
References: <1404361654-2894-1-git-send-email-sthokal@xilinx.com>
 <20140716173824.GA24357@google.com>
 <CA+mB=1JupzQy+R14kKAk7mTJR2FcZ+cQv-uXQSB6jEVBW95aGQ@mail.gmail.com>
Message-ID: <CAErSpo41HwMferWm8q69Sz0t-Cs1WHgwwVp1VKsoxxyvrgQhfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 11:10 PM, Srikanth Thokala <sthokal@xilinx.com> wrote:
> On Wed, Jul 16, 2014 at 11:08 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> ...
>> I see I forgot to ask for a MAINTAINERS entry for this driver.  Can
>> you add one?
>
> There was a discussion on this earlier and Michal mentioned it is not
> required as it is
> handled by our Xilinx record.
>
> Here is the reply from Michal to the MAINTAINERS update comment,
>
> < Reply from Michal >
>
>> Please also include a MAINTAINERS update for drivers/pci/host/pci-xilinx.c.
>
> This should be handle by our record that's why MAINTAINERS update is
> not necessary.
> (N: xilinx below)

That's technically true in the sense that get_maintainer.pl will do
the right thing, but I often review patches in email (without
extracting them), so it's more convenient to just look in MAINTAINERS
to see if they have the right acks.  But I guess I can deal with it
either way.

> ARM/ZYNQ ARCHITECTURE
> M:      Michal Simek <michal.simek@xilinx.com>
> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> W:      http://wiki.xilinx.com
> T:      git git://git.xilinx.com/linux-xlnx.git
> S:      Supported
> F:      arch/arm/mach-zynq/
> F:      drivers/cpuidle/cpuidle-zynq.c
> N:      zynq
> N:      xilinx
