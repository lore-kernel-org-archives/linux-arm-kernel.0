From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:15:59 +0100
Subject: [PATCH 1/5] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <5017F514.4030106@linaro.org>
References: <1343745944-18418-1-git-send-email-lee.jones@linaro.org>
 <1343745944-18418-2-git-send-email-lee.jones@linaro.org>
 <20120731145614.GZ4468@opensource.wolfsonmicro.com>
 <5017F514.4030106@linaro.org>
Message-ID: <20120731151559.GB4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 04:09:08PM +0100, Lee Jones wrote:
> On 31/07/12 15:56, Mark Brown wrote:

> >To reiterate, this is in *no* way urgent or even a bug fix.

> It fixes sound in our driver.

> Without this the card failes to instantiate.

You're kidding, right?  Fix the actual error.

> Isn't the return code incorrect? There are a multitude of reasons
> why snd_soc_dapm_new_control() would fail. No-memory is just one of
> them, so why do we force this probable lie?

I don't think anyone actually cares what the error code is, feel free to
pick another random number.
