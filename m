From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 1 Aug 2013 10:50:25 -0600
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 7:25 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
>
> This patch set is intended for merging in 3.12, so the respective
> maintainers of the different areas are invited to review/ack the
> patches, see below for the details. Note that several of those patches
> are also needed for the Tegra PCIe driver.
>
> There are still missing ACKs from Grant Likely (5, 6, 7), Thomas
> Gleixner (8, 9) and Bjorn Helgaas (2, 12).

I just acked 2, and my ack is already on 12.  Let me know if you need
anything else from me.

Bjorn
