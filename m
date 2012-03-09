From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 16:32:18 -0800
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators
 for v3.4
In-Reply-To: <87399jc6cj.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com>
Message-ID: <20120309003217.GB12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120308 09:37]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@ti.com> [120307 11:42]:
> >> Tony,
> >> 
> >> Please pull the following support for using regulators to control the
> >> on-chip VC/VP managed voltage domains.
> >> 
> >> The regulator driver support for this is already queued in the regulator
> >> tree, and this is the supporting core work.
> >> 
> >> This combined with the CPUfreq changes to use the regulator framework
> >> will finally result in MPU DVFS working in mainline.
> >
> > Nice.. However this one might be missing some header changes?
> 
> Oh, that's because it depends on the regulator core changes that are in
> Mark's regulator tree.  You need the for-next branch of :
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
> 
> For this to compile correctly.
> 
> Sorry, I should've been more clear above about the build dependency.

Hmm just checking.. Recently Mark replied to Peter:

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120228 02:17]:
> On Tue, Feb 28, 2012 at 09:40:10AM +0200, Peter Ujfalusi wrote:
>
> > NOTE: this series has been generated agains Takashi's topic/asoc branch merged
> > with Mark's for-next branch since this series depends on changes in Marks'
> > branch, but not yet pulled by Takashi (snd_soc_add_dai_controls implementation
> > from Liam).
>
> Never base *anything* off my for-next branch, it gets rebuilt regularly.

So can you guys please confirm that if is indeed an immutable
commit to use as a base to merge in something?

Regards,

Tony
