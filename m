From: broonie@kernel.org (Mark Brown)
Date: Sat, 14 Feb 2015 12:22:55 +0800
Subject: [PATCH 0/4] ASoC: samsung: clean up references to outdated
 Kconfig symbols
In-Reply-To: <1423646498.21685.35.camel@x220>
References: <1421664067.9655.51.camel@x220>
 <20150206235044.GO31311@finisterre.sirena.org.uk>
 <1423298284.2246.5.camel@x220>
 <20150209060704.GB19229@finisterre.sirena.org.uk>
 <1423646498.21685.35.camel@x220>
Message-ID: <20150214042255.GA9110@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 10:21:38AM +0100, Paul Bolle wrote:

> TL;DR: what exactly should I resend and when?

This is disappointing; you're someone who's been contributing for quite
some time now, I'd really expect you to be faimilar with the process of
submitting patches and able to identify answers to your questions.

> > What's posted doesn't apply against -next.

> That's because of trivial conflicts with commit a59aa180ea56 ("ASoC:
> samsung: Replace depends on REGMAP_I2C with depends on I2C"). That
> commit landed in next-20150127 (ie, eight days after I sent this short
> series). I guess I resolved these conflicts in the local version of
> these patches and promptly forgot about them, as they were so trivial.

For something like this I'm just not even going to look at what's
required to fix up by hand, sorry.

> > As ever submit against the tree listed in MAINTAINERS

> >    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

> Which is not entirely obvious, since this series only touches files
> below sound/soc/samsung/. That directory is mentioned in MAINTAINERS
> under "ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" and under "SAMSUNG AUDIO
> (ASoC) DRIVERS". (Why does that directory need two entries?) Neither
> entry mention a repository.

Of course neither of those entries list me either yet you managed to
figure out that you should send the patch to me.  The same process that
helps you identify that things should be submitted to the subsystem
maintainers should allow you to identify where they're likely to try to
apply changes.  Or simply looking at how other similar patches get
merged.

> And now I wonder what I should resend: the three patches 2/4, 3/4, and
> 4/4 with the trivial conflicts resolved or the entire series? And when
> do you prefer I resend?

Again this is something I'd really expect you to be familiar with.  As
ever if there are changes you would like to see integrated into the
kernel then please submit them using the normal patch submission
process.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150214/7d208b49/attachment-0001.sig>
