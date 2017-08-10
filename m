From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Aug 2017 16:31:58 +0100
Subject: [PATCH 1/2] ASoC: codecs: add const to snd_soc_codec_driver
 structures
In-Reply-To: <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
 <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
 <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
Message-ID: <20170810153158.hfnzjzro7wnmc4mt@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 08:56:35PM +0530, Bhumika Goyal wrote:
> On Thu, Aug 10, 2017 at 8:50 PM, Mark Brown <broonie@kernel.org> wrote:

> > This is difficult to apply against current code as it is a single commit
> > over lots of files but the ASoC tree has lots of branches.  I've figured
> > out the dependencies but it's easier to split things up (and avoids
> > collisions with other changes causing the whole thing to not apply).

> Thanks for the response.
> Should I make separate patches for each file or is there another way
> to split this patch?

Splitting per driver would've been easier, or saying exactly where it
applies if you don't split it.  Like I say I figured it out for this one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/207114c1/attachment.sig>
