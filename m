From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:18:20 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <5017F68B.3060400@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
Message-ID: <20120731151819.GC4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 04:15:23PM +0100, Lee Jones wrote:
> On 31/07/12 15:54, Mark Brown wrote:

> >You might want to look at a better mail program.

> Willingly. Any good suggestions?

mutt works for me.

> >It's certainly totally inappropriate for an "urgent" bugfix.

> Well it just means that audio won't work for the ux500 for this
> kernel release, but as we're waiting on clocks, this isn't a big
> issue for us. If you do take it (with or without the return code),
> feel free to add it to for-next instead of the -rc:s

I'm not going to apply this patch.  This isn't a vendor BSP, we
shouldn't be putting random hacks like this in core code.
