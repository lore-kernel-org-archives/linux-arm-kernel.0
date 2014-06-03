From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 03 Jun 2014 15:22:47 +0200
Subject: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
In-Reply-To: <20140530173053.GF4607@google.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
 <20140424175844.GD29593@google.com>
 <1398421265.4657.25.camel@weser.hi.pengutronix.de>
 <CAErSpo7Boi8d+apAUC3TmmE33LuRMYJ6J+TEPLRbeyZyU3O8RQ@mail.gmail.com>
 <1398774686.4677.12.camel@weser.hi.pengutronix.de>
 <1399885183.5016.4.camel@weser.hi.pengutronix.de>
 <20140530173053.GF4607@google.com>
Message-ID: <1401801767.5422.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjorn,

Am Freitag, den 30.05.2014, 11:30 -0600 schrieb Bjorn Helgaas:
> On Mon, May 12, 2014 at 10:59:43AM +0200, Lucas Stach wrote:
> > Hi Bjorn,
> > 
> > just a friendly reminder. It would be nice if you could pull those in.
> > 
> > Shawn already pulled the DT change and as it is a binding change this
> > means PCIe on i.MX6 is broken in -next, as long as the remaining patches
> > are missing.
> 
> I applied these to pci/host-imx6 for v3.16.
> 
> Sorry I didn't do this sooner; I get a lot of email and it's easy to
> overlook things.  I mostly work from patchwork
> (http://patchwork.ozlabs.org/project/linux-pci/list/?order=date), and I had
> dropped this series from there because there was enough discussion that I
> expected a re-post, so it wasn't on my radar screen anymore.
> 
> Bjorn
> 
> > Am Dienstag, den 29.04.2014, 14:31 +0200 schrieb Lucas Stach:
> > > Hi Bjorn,
> > > 
> > > Am Freitag, den 25.04.2014, 08:39 -0600 schrieb Bjorn Helgaas:
> > > [...]
> > > > >> >   PCI: designware: split Exynos and i.MX bindings

It seems you missed this one patch. This isn't too urgent, as it is just
the doc update, but it should still go into 3.16 along with the other
changes. I would have expected that is ok for this to go through your
tree.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
