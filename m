From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Jan 2011 19:16:27 +0000
Subject: [alsa-devel] ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <87ei8aytpj.fsf@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
	<87ei8aytpj.fsf@ti.com>
Message-ID: <20110118191626.GA17591@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 10:04:08AM -0800, Kevin Hilman wrote:
> "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> writes:

> > On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> > But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> > has the wrong AIC3x codec slave address. This patch fixes this issue.

> As suggested by Sergei...

> This part should be one patch, and merged by Liam via ASoC tree for
> 2.6.38-rc cycle.

When reposting remember to CC the maintainers for the subsystem on the
patch (as always when posting patches).
