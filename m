From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 29 Oct 2013 09:31:11 +0000
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131029040209.GC8812@MrMyself>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131029040209.GC8812@MrMyself>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8286D2E8@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> -----Original Message-----
> From: Chen Guangyu-B42378
> Sent: Tuesday, October 29, 2013 12:02 PM
> To: Xiubo Li-B47053
> Cc: Mark Brown; Guo Shawn-R65073; timur at tabi.org; lgirdwood at gmail.com;
> Jin Zhengxiong-R64188; rob.herring at calxeda.com; pawel.moll at arm.com;
> mark.rutland at arm.com; swarren at wwwdotorg.org; ian.campbell at citrix.com;
> rob at landley.net; linux at arm.linux.org.uk; perex at perex.cz; tiwai at suse.de;
> grant.likely at linaro.org; Estevam Fabio-R49496; LW at KARO-electronics.de;
> oskar at scara.com; shawn.guo at linaro.org; Wang Huan-B18965;
> devicetree at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; alsa-
> devel at alsa-project.org; linuxppc-dev at lists.ozlabs.org
> Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface
> driver.
> 
> On Tue, Oct 29, 2013 at 12:00:57PM +0800, Xiubo Li-B47053 wrote:
> > > There's a patch in -next that lets the generic dmaengine code figure
> > > out some settings from the dmacontroller rather than requiring the
> > > driver to explicitly provide configuration - it's "ASoC:
> > > dmaengine-pcm: Provide default config".  Please update your driver
> > > to use this, or let's work out what it doesn't do any try to fix it.
> > >
> >
> > I couldn't find the patch in the next and other trees.
> > Does this patch has been submitted to the -next tree ?
> > Or could you tell me how to find the patch please?
> >
> 
> Are you using broonie's repository?

NO.

> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> 
> If you searched the title in for-next branch, you should have found it.
> 
Yes, find it.
Thanks very much.

--
Xiubo
