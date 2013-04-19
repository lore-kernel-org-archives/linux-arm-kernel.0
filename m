From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 15:06:33 +0100
Subject: [PATCH v3] ARM: pci: create pci_common_init_dev()
In-Reply-To: <20130413102929.GB30758@avionic-0098.mockup.avionic-design.de>
References: <1365788748-7908-1-git-send-email-linus.walleij@linaro.org>
 <20130413102929.GB30758@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130419140633.GS14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 13, 2013 at 12:29:29PM +0200, Thierry Reding wrote:
> On Fri, Apr 12, 2013 at 07:45:48PM +0200, Linus Walleij wrote:
> [...]
> > +static inline void pci_common_init(struct hw_pci *hw) {
> 
> I think that the CodingStyle rule for putting the opening brace on a
> line by itself also applies to inline functions.
> 
> Aside from that nit:
> 
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

Strangely the patch never came through the mailing list.  Where can it
be found?  Obviously this is core ARM code which is being touched so
it should've been copied to me.
