From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Jun 2013 11:19:34 +0100
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <877ghp6dg9.fsf@linaro.org>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <877ghp6dg9.fsf@linaro.org>
Message-ID: <20130620101934.GB23833@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Jun 19, 2013 at 09:41:10PM +0100, Kevin Hilman wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > Hi Russell, all,
> >
> > even though I think this set is ready to get merged, it would be great
> > if we can test it on as many platforms as possible since it touches core
> > suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
> > and there are many.
> >
> > I pushed out a branch:
> >
> > git://linux-arm.org/linux-2.6-lp.git mpidr-linearization
> >
> > if anyone has time to test the set that would be really great, thank you
> > very much.
> 
> I'm a little late to the party, but I tested this on OMAP4 with the CPUs
> hitting off in the lower C-states.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>

That's great, thank you very much !

Lorenzo
