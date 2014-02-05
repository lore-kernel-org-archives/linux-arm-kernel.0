From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Feb 2014 14:08:08 +0000
Subject: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
 parameters from EDID
In-Reply-To: <52F23D1D.7040804@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
 <1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
 <20140204180625.GM22609@sirena.org.uk>
 <20140205101134.4591e5c3@armhf> <52F2021A.9020804@metafoo.de>
 <20140205111814.GF22609@sirena.org.uk>
 <52F23D1D.7040804@metafoo.de>
Message-ID: <20140205140808.GI22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 02:31:09PM +0100, Lars-Peter Clausen wrote:
> On 02/05/2014 12:18 PM, Mark Brown wrote:

> >...as previously requested.  I know there was some discusion of broader
> >moves to factor this stuff out but it'd still be good to keep it
> >separated out even prior to a final non-EDID based solution so it's
> >easier to refactor.

> I think it will always be EDID (or ELD) based. As I understood it
> the re-factoring Takashi was talking about is related to how this
> data is passed from the graphics driver to the audio driver. The way

Right, the data of course has to come from there originally, it's about
how we pass the data and updates to it around.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/5244a05d/attachment.sig>
