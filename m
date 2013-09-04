From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 16:05:40 +0100
Subject: [PATCH 11/11] iio: pressure-core: st: Provide correct regulator
 support
In-Reply-To: <20130904132638.GG20150@lee--X1>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-12-git-send-email-lee.jones@linaro.org>
 <20130904131111.GJ18206@e106331-lin.cambridge.arm.com>
 <5227331A.5050507@metafoo.de> <20130904132638.GG20150@lee--X1>
Message-ID: <20130904150540.GA10849@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 02:26:38PM +0100, Lee Jones wrote:
> On Wed, 04 Sep 2013, Lars-Peter Clausen wrote:

> > > I think this would be better handled with something like Mark Brown's
> > > suggested regulator_get_optional [1,2].

> Thanks Mark, I didn't know that existed.

It's only just gone into Linus' tree this merge window so it's very new.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/6ceaf0c4/attachment.sig>
