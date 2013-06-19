From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 19 Jun 2013 12:05:44 -0400 (EDT)
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <20130619155942.GD5276@e102568-lin.cambridge.arm.com>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1306111150270.18597@syhkavp.arg>
 <20130619155942.GD5276@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1306191203450.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jun 2013, Lorenzo Pieralisi wrote:

> Hi Russell, all,
> 
> On Tue, Jun 11, 2013 at 04:58:45PM +0100, Nicolas Pitre wrote:
> > On Tue, 11 Jun 2013, Lorenzo Pieralisi wrote:
> > 
> > > Hi Russell, all,
> > > 
> > > even though I think this set is ready to get merged, it would be great
> > > if we can test it on as many platforms as possible since it touches core
> > > suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
> > > and there are many.
> > > 
> > > I pushed out a branch:
> > > 
> > > git://linux-arm.org/linux-2.6-lp.git mpidr-linearization
> > > 
> > > if anyone has time to test the set that would be really great, thank you
> > > very much.
> > 
> > Since a lot of big.LITTLE related code, including proper TC2 support, is 
> > being withheld by this, I would suggest we wait say a week for people to 
> > test and report any issue they might have, after which it should simply 
> > be merged.  Some people will test such code only after it is merged 
> > anyway.
> > 
> > @Lorenzo: Why not ask for this branch to be included in linux-next right 
> > away? This way you'll get implicit testing.
> 
> The series was added to -next last Monday, so far just a merge conflict
> reported, no issues raised. Can I request a pull or should we wait one
> week more, leave it in -next to enable further testing and then proceed ?

With the positive test results that were posted so far I would be 
confident enough to send a pull request now.


Nicolas
