From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Fri, 03 Feb 2012 08:45:10 +0100
Subject: [alsa-devel] [RFC PATCH] ARM ASoC: add sound driver for imx27pdk
 using mc13783 codec
In-Reply-To: <20120202173212.GA1785@sirena.org.uk>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
 <2851519.TkeCdfD43W@laptop> <20120202173212.GA1785@sirena.org.uk>
Message-ID: <1635894.OLo8mNMWim@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 2 f?vrier 2012 17:32:12 Mark Brown a ?crit :
> On Sun, Jan 29, 2012 at 08:01:38PM +0100, Philippe R?tornaz wrote:
> > Le samedi 28 janvier 2012 18:57:45 Fabio Estevam a ?crit :
> > > On Wed, Jan 25, 2012 at 1:45 PM, Philippe R?tornaz
> > > 
> > > > Sascha, do you have any plan to upstream the mc13783 codec
> > > > driver ?
> > > 
> > > In case Sascha doesn't have plans to upstream mc13783, is this
> > > something you could do?
> > 
> > It's an option, but I cannot work full-time on it so it would not be
> > fast.
> First step would be to post it :)
> 
> A useful approach might be to strip the driver down to the bare minimum
> (for example just getting DAC to headphone working, possibly at a fixed
> sample rate) and then build out functionality incrementally.  That would
> make it easier for different people to contribute bits they need.

Well, that was the whole point to post a link to a git tree containing the 
patches. But if you think I should post the patches directly on the mailing 
list I can do it.

But before investing too much time on it I would really like to have Sascha 
opinion about it as he is the main author of the mc13783 codec code.

Thanks,

Philippe
