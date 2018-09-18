From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 18 Sep 2018 14:15:12 +0200
Subject: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <20180917175753.GE2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
 <20180917175753.GE2471@sirena.org.uk>
Message-ID: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-09-17 at 10:57 -0700, Mark Brown wrote:
> On Mon, Sep 17, 2018 at 01:35:55PM +0200, Lubomir Rintel wrote:
> > This is the SPI controller found on Marvel MMP2 and perhaps more
> > platforms.
> 
> I'm missing patches 2 and 5 from this series.  What's going on with
> them, are there any dependencies?

Sorry, I was not sure how to Cc people properly. I haven't dealt with a
patchset that spanned multiple subsystems before.

I thought it might have been a good idea to add individual people
suggested by get_maintainer.pl in commits' "Cc:" tag, while passing the
lists to --cc argument of git send-email.

Should I've Cc'd everyone on the full series, even if only a patch or
two might be really interesting to them? How do I decide whether the
recipient needs to be in the commit's commit message (as opposed to
just --cc on a command line)?

https://lore.kernel.org/lkml/20180917113559.11101-1-lkundrak at v3.sk/

> 
> > Changes since v1:
> > - s/ssp at d4035000/spi at d4035000/
> 
> As covered in SubmittingPatches please put inter-version changelogs
> after the --- so they don't end up in the commits.

Will do. I was actually not sure about that, so I took a short look at
the git log, and it seemed to me that commit messages with the
changelogs are quite common.

Thanks you,
Lubo
