From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 14 May 2013 18:21:32 -0400 (EDT)
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <20130514130005.GD29592@e102654-lin.cambridge.arm.com>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20130514130005.GD29592@e102654-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1305141820280.31158@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 May 2013, Javi Merino wrote:

> On Thu, May 09, 2013 at 11:34:00AM +0100, Lorenzo Pieralisi wrote:
> 
> > +static inline void init_cpu_port(struct cpu_port *port, u32 index, u32 mpidr)
> 
> The mpidr should be u64.

Why?


Nicolas
