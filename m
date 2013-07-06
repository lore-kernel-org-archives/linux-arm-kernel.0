From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 6 Jul 2013 12:17:43 -0400
Subject: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
In-Reply-To: <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
 <20130706135433.GL2569@titan.lakedaemon.net>
 <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
Message-ID: <20130706161743.GM2569@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 09:40:55AM -0600, Bjorn Helgaas wrote:
> On Sat, Jul 6, 2013 at 7:54 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
> >> Dear Bjorn Helgaas,
> >>
> >> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
> >>
> >> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> >
> >> > Again, please update the subject line to "PCI: Remove ..."
> >> >
> >> > I doubt that you'll get explicit acks from all the arches you touched,
> >> > but I think it's reasonable to put at least patches 2 & 3 in -next
> >> > soon after v3.11-rc1, so we should have time to shake out issues.
> >>
> >> Sure. Which merge strategy do you suggest for this patch series, which
> >> touches a number of different areas, and has some build-time
> >> dependencies between the patches (if needed, I can detail those build
> >> time dependencies to help figuring out the best strategy).
> >
> > If we end up handling this the same as the of/pci & mvebu-pcie series
> > (whole series through mvebu -> arm-soc) I can have it up in -next within
> > a few days of -rc1.  Just let me know.
> 
> That sounds fine with me.  I don't think it's worth trying to split
> out the drivers/pci stuff and trying to coordinate it going through
> different trees.

Ok, will do.

Thomas, I assume there will be one more version to address Bjorn's last
comments?

thx,

Jason.
