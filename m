From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Mon, 5 Oct 2015 11:15:28 +0530
Subject: ARM64 PCIe legacy interrupts
In-Reply-To: <loom.20151001T142318-555@post.gmane.org>
References: <loom.20151001T142318-555@post.gmane.org>
Message-ID: <CAHM4w1kzt0wCCxfvofXqzgK=Te50_1ZsYnApbEojMQq8x+wcdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 5:59 PM, bharat kumar gogada <bharatku@xilinx.com> wrote:
> Hi, in ARM32 bit pci_fixup_irqs is being used to support legacy interrupts,
> in ARM64 how legacy interrupts are being handled

See, arch/arm64/kernel/pci.c:pcibios_add_devices()
