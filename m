From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 29 Aug 2013 10:00:53 +0100
Subject: [GIT PULL] ARM: TC2: CPU idle big.LITTLE driver
In-Reply-To: <20130828183624.GH8607@quad.lixom.net>
References: <20130812153422.GA6426@e102568-lin.cambridge.arm.com>
 <20130825090848.GA12256@e102568-lin.cambridge.arm.com>
 <20130828183624.GH8607@quad.lixom.net>
Message-ID: <20130829090053.GA2878@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 07:36:24PM +0100, Olof Johansson wrote:
> On Sun, Aug 25, 2013 at 10:08:48AM +0100, Lorenzo Pieralisi wrote:
> > Hi Olof, Kevin,
> > 
> > On Mon, Aug 12, 2013 at 04:34:22PM +0100, Lorenzo Pieralisi wrote:
> > > Hi Olof, Kevin,
> > > 
> > > please pull this patch series that provides a CPU idle driver for the vexpress
> > > TC2 testchip, and it is a stepping stone towards an ARM unified CPU idle driver
> > > based on the MCPM framework.
> > > 
> > > Series is based against this pull request from Pawel which is a strict
> > > dependency and they must be merged in order:
> > > 
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html
> > 
> > May I ask you please the status of this pull request ? It is to know if
> > it is ok as it is or I have to do something on my side, thanks.
> 
> This needed a rebase on top of the latest version of the mcpm backend branch,
> since it's based on an older version.

Yes, I mentioned that in other threads, just wanted to avoid sending another
pull request when patches still apply cleanly, there was no real reson to do
that.

> I also don't see an ack from any of the cpuidle maintainers, if you want to
> take it through arm-soc you need to get them to ack it for that purpose. I see
> that you got an informal "It sounds good to me" in
> http://www.spinics.net/lists/arm-kernel/msg266442.html, but please be diligent
> in collecting these in the future.

Daniel signed off the CPU idle driver patch; as for the two other patches, one
is co-authored with Nico, and one is a one-liner that just updates the
vexpress MCPM back-end. I think this should be enough, but your point is taken,
I just could not ask Daniel to ack a patch he already signed off.

> So, I've essentially applied the topmost 3 patches in a new branch that's based
> on our version of vexpress/mcpm, and merged that in.

That's great, thank you very much, please let me know if you need help.

Thanks,
Lorenzo
