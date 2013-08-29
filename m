From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 10:07:18 -0700
Subject: [GIT PULL 1/2] ARM: mvebu: MSI/PCI changes for v3.12
In-Reply-To: <20130816125502.GR13964@titan.lakedaemon.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
 <20130816062609.GF7035@quad.lixom.net>
 <20130816125502.GR13964@titan.lakedaemon.net>
Message-ID: <20130829170718.GD18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 08:55:02AM -0400, Jason Cooper wrote:
> On Thu, Aug 15, 2013 at 11:26:09PM -0700, Olof Johansson wrote:
> > Hi,
> > 
> > On Wed, Aug 14, 2013 at 03:10:11PM -0400, Jason Cooper wrote:
> > 
> > >       PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms
> > 
> > I can't find this patch posted anywhere, and it lacks acks. For trivial code in
> > your own subsystem that's sometimes ok, but this cuts across to PCI.
> 
> oops, you're right.  I've forwarded the email where Bjorn said the
> change looked ok.  I missed that the original build failure didn't Cc:
> any MLs.

Pulled in under next/drivers.


-Olof
