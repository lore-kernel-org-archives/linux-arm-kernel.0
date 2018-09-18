From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Sep 2018 10:43:03 -0700
Subject: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
In-Reply-To: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
 <20180917175753.GE2471@sirena.org.uk>
 <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
Message-ID: <20180918174303.GU2471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2018 at 02:15:12PM +0200, Lubomir Rintel wrote:
> On Mon, 2018-09-17 at 10:57 -0700, Mark Brown wrote:

> > > Changes since v1:
> > > - s/ssp at d4035000/spi at d4035000/

> > As covered in SubmittingPatches please put inter-version changelogs
> > after the --- so they don't end up in the commits.

> Will do. I was actually not sure about that, so I took a short look at
> the git log, and it seemed to me that commit messages with the
> changelogs are quite common.

For various reasons the drm subsystem explicitly does the opposite
thing and it does leak out in other places (eg, when someone does it and
then it doesn't get fixed up), it's a bit unfortunate that there's some
divergence here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180918/067c4843/attachment.sig>
