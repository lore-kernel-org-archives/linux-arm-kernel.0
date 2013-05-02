From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 2 May 2013 18:20:32 +0100
Subject: [PATCH v10 0/2] (arm-soc for v3.10) arm: introduce
 psci_smp_ops
In-Reply-To: <20130502171516.GA3040@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1304301707290.5398@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1305021811560.5398@kaball.uk.xensource.com>
 <20130502171516.GA3040@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1305021816490.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013, Will Deacon wrote:
> Hi Stefano,
> 
> On Thu, May 02, 2013 at 06:12:12PM +0100, Stefano Stabellini wrote:
> > ping
> 
> Is this a ping to have this pulled into Russell's tree?

I thought that we agreed that the patches should go via the arm-soc
tree, after Russell acks them.

The ping is for Russell to ack them and Arnd to merge them.


> If so, might be
> worth sending a pull request to linux+pull at arm.linux.org.uk.
> 
> Has this been in -next?

Yes they have, because I temporarily added them to my branch in
linux-next.
In fact Stephen found and solved a merge conflict here:

http://marc.info/?l=linux-arm-kernel&m=136722292031420&w=2
