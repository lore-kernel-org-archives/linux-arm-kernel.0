From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 17:32:12 +0000
Subject: [alsa-devel] [RFC PATCH] ARM ASoC: add sound driver for
 imx27pdk using mc13783 codec
In-Reply-To: <2851519.TkeCdfD43W@laptop>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
 <2667396.yifGumf5nD@laptop>
 <CAOMZO5CRmvwCy_qE81PauZ6jmPN7S3N3pky01V0OmWBLCJ5JyA@mail.gmail.com>
 <2851519.TkeCdfD43W@laptop>
Message-ID: <20120202173212.GA1785@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 08:01:38PM +0100, Philippe R?tornaz wrote:
> Le samedi 28 janvier 2012 18:57:45 Fabio Estevam a ?crit :
> > On Wed, Jan 25, 2012 at 1:45 PM, Philippe R?tornaz

> > > Sascha, do you have any plan to upstream the mc13783 codec driver ?

> > In case Sascha doesn't have plans to upstream mc13783, is this
> > something you could do?

> It's an option, but I cannot work full-time on it so it would not be fast.

First step would be to post it :)

A useful approach might be to strip the driver down to the bare minimum
(for example just getting DAC to headphone working, possibly at a fixed
sample rate) and then build out functionality incrementally.  That would
make it easier for different people to contribute bits they need.
