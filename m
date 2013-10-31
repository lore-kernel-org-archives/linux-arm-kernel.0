From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 09:26:18 +0800
Subject: [PATCH 0/6] PCI: imx6: Random fixes
In-Reply-To: <CAErSpo5dcqA+OkORmPO41THd+QaG53jXgZPogw3U5-1GP-hyoA@mail.gmail.com>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
 <201310301552.28866.marex@denx.de>
 <CAErSpo5dcqA+OkORmPO41THd+QaG53jXgZPogw3U5-1GP-hyoA@mail.gmail.com>
Message-ID: <20131031012615.GA19362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 10:25:37AM -0600, Bjorn Helgaas wrote:
> > Can you maybe pick at least these two:
> >
> > PCI: imx6: Make reset-gpio optional

Isn't there a comment from Jingoo on this patch unresolved?

> > PCI: imx6: Probe the PCIe in fs_initcall()

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> >
> > I think they should be harmless and the later one fixes a problem on MX6. I'm
> > now digging in the PCIe MX6 again btw.
> 
> I'm fine with taking these as long as Shawn acks them.
> 
> Bjorn
