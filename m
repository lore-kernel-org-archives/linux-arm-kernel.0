From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 2 May 2013 19:42:58 +0100
Subject: [PATCH v10 0/2] (arm-soc for v3.10) arm: introduce
 psci_smp_ops
In-Reply-To: <20130502182812.GD14496@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1304301707290.5398@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1305021811560.5398@kaball.uk.xensource.com>
 <20130502171516.GA3040@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1305021816490.5398@kaball.uk.xensource.com>
 <20130502182812.GD14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1305021938170.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013, Russell King - ARM Linux wrote:
> On Thu, May 02, 2013 at 06:20:32PM +0100, Stefano Stabellini wrote:
> > On Thu, 2 May 2013, Will Deacon wrote:
> > > Hi Stefano,
> > > 
> > > On Thu, May 02, 2013 at 06:12:12PM +0100, Stefano Stabellini wrote:
> > > > ping
> > > 
> > > Is this a ping to have this pulled into Russell's tree?
> > 
> > I thought that we agreed that the patches should go via the arm-soc
> > tree, after Russell acks them.
> 
> Okay, well, is there a reason for them to go through arm-soc?  They
> look more like core code to me than SoC specific - they only minimally
> touch mach-virt.

The original reason is that some SoC specific code depends on this
series (Calxeda I believe).

But you are probably right, if you prefer that I issue a pull request
for your tree, I have no problems with that.
