From: b42378@freescale.com (Nicolin Chen)
Date: Tue, 29 Oct 2013 12:02:10 +0800
Subject: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <20131024110543.GA18506@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8286BDB5@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131029040209.GC8812@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 12:00:57PM +0800, Xiubo Li-B47053 wrote:
> > There's a patch in -next that lets the generic dmaengine code figure out
> > some settings from the dmacontroller rather than requiring the driver to
> > explicitly provide configuration - it's "ASoC: dmaengine-pcm: Provide
> > default config".  Please update your driver to use this, or let's work
> > out what it doesn't do any try to fix it.
> > 
> 
> I couldn't find the patch in the next and other trees.
> Does this patch has been submitted to the -next tree ?
> Or could you tell me how to find the patch please?
>

Are you using broonie's repository?
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

If you searched the title in for-next branch, you should have found it.

Best regards,
Nicolin Chen
