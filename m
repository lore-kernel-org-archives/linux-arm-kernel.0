From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 5 May 2014 07:49:00 -0400
Subject: [GIT PULL] ARM: mvebu: pci/mbus fixes for v3.15
In-Reply-To: <20140505054033.GD16022@quad.lixom.net>
References: <20140429131101.GI28159@titan.lakedaemon.net>
 <20140505054033.GD16022@quad.lixom.net>
Message-ID: <20140505114900.GK28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 10:40:33PM -0700, Olof Johansson wrote:
> On Tue, Apr 29, 2014 at 09:11:01AM -0400, Jason Cooper wrote:
> > arm-soc guys,
> > 
> > This rather large (for fixes) changeset resolves multiple problems with
> > the mvebu PCIe driver.  While it works fine for simple use cases, more
> > complicated uses highlighted multiple problems with MSI handling and mbus
> > window creation.
> > 
> > These changes are Acked by the appropriate maintainers and have been in
> > -next for about a week.
> 
> Merged all three. We usually don't split up fixes in separate branches, so no
> need to do so in the future.

Noted.  The mbus/pci/irqchip fix series was a complicated one, but I
could've (should've) merged it into mvebu/fixes before sending the pull
request.  Will do so in the future.

We've (mvebu, and other sub-archs afaict) been splitting /fixes and
/dt-fixes for a while now.  Which I think helps reinforce the
independence of the two.  Do you want those merged together as well,
now?

thx,

Jason.
