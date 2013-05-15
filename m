From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 May 2013 15:55:57 +0100
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <alpine.LFD.2.03.1305151037330.31158@syhkavp.arg>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20130514130005.GD29592@e102654-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1305141820280.31158@syhkavp.arg>
 <20130515142441.GA385@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1305151037330.31158@syhkavp.arg>
Message-ID: <20130515145557.GB385@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 03:51:43PM +0100, Nicolas Pitre wrote:
> On Wed, 15 May 2013, Lorenzo Pieralisi wrote:
> 
> > On Tue, May 14, 2013 at 11:21:32PM +0100, Nicolas Pitre wrote:
> > > On Tue, 14 May 2013, Javi Merino wrote:
> > > 
> > > > On Thu, May 09, 2013 at 11:34:00AM +0100, Lorenzo Pieralisi wrote:
> > > > 
> > > > > +static inline void init_cpu_port(struct cpu_port *port, u32 index, u32 mpidr)
> > > > 
> > > > The mpidr should be u64.
> > > 
> > > Why?
> > 
> > Since on arm64 MPIDR_EL1 size is 64 bits, we need the driver to work on
> > both arm and arm64.
> 
> OK.
> 
> Are you OK for me to carry this patch in the series for MCPM support 
> on RTSM?  I would like to send it to arm-soc ASAP.

Absolutely, I will apply the latest fixes and send the updated version
to you for arm-soc inclusion today.

Lorenzo
