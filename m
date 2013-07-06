From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 6 Jul 2013 09:54:33 -0400
Subject: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
In-Reply-To: <20130705234501.1341f52e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
Message-ID: <20130706135433.GL2569@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 11:45:01PM +0200, Thomas Petazzoni wrote:
> Dear Bjorn Helgaas,
> 
> On Fri, 5 Jul 2013 15:37:33 -0600, Bjorn Helgaas wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Again, please update the subject line to "PCI: Remove ..."
> > 
> > I doubt that you'll get explicit acks from all the arches you touched,
> > but I think it's reasonable to put at least patches 2 & 3 in -next
> > soon after v3.11-rc1, so we should have time to shake out issues.
> 
> Sure. Which merge strategy do you suggest for this patch series, which
> touches a number of different areas, and has some build-time
> dependencies between the patches (if needed, I can detail those build
> time dependencies to help figuring out the best strategy).

If we end up handling this the same as the of/pci & mvebu-pcie series
(whole series through mvebu -> arm-soc) I can have it up in -next within
a few days of -rc1.  Just let me know.

hth,

Jason.
