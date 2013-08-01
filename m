From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Aug 2013 19:58:56 +0200
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
Message-ID: <20130801195856.00f78934@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Thu, 1 Aug 2013 10:50:25 -0600, Bjorn Helgaas wrote:
> On Thu, Aug 1, 2013 at 7:25 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Hello,
> >
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> >
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. Note that several of those patches
> > are also needed for the Tegra PCIe driver.
> >
> > There are still missing ACKs from Grant Likely (5, 6, 7), Thomas
> > Gleixner (8, 9) and Bjorn Helgaas (2, 12).
> 
> I just acked 2, and my ack is already on 12.  Let me know if you need
> anything else from me.

That's good, thanks a lot!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
