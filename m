From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 24 Mar 2015 19:04:05 +0000
Subject: [PATCH 2/2] ARM: cpuidle: Document the code
In-Reply-To: <20150324185144.GB27311@red-moon>
References: <20150323225828.GC15435@e102568-lin.cambridge.arm.com>
 <1427190842-30675-1-git-send-email-daniel.lezcano@linaro.org>
 <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org>
 <20150324185144.GB27311@red-moon>
Message-ID: <20150324190405.GC27311@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 06:51:44PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Mar 24, 2015 at 09:54:02AM +0000, Daniel Lezcano wrote:

[...]

> > +/*
> > + * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
> > + * @cpu: the cpu to be initialized
> > + *
> > + * Initialize the cpuidle ops with the device for the cpu and then call
> > + * the cpu's idle initialization callback. This may fail if the underlying HW
> > + * is not operational.
> > + *
> > + * Returns:
> > + *  0 on success,
> > + *  -ENODEV if it fails to find the cpu node in the device tree,
> > + *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for this cpu,
> > + *  -ENOENT if it fails to find a enabled-method property,
> 
> Ultra-nit: "an enabled-method"

Bah, I cannot see the wood for the trees anymore. "an enable-method".

Lorenzo
