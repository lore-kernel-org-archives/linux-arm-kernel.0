From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Aug 2017 16:20:10 +0100
Subject: [PATCH 1/2] ASoC: codecs: add const to snd_soc_codec_driver
 structures
In-Reply-To: <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
Message-ID: <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 09:30:19PM +0530, Bhumika Goyal wrote:

>  sound/soc/codecs/88pm860x-codec.c      | 2 +-
>  sound/soc/codecs/ab8500-codec.c        | 2 +-
>  sound/soc/codecs/ac97.c                | 2 +-
>  sound/soc/codecs/ad1836.c              | 2 +-
>  sound/soc/codecs/ad193x.c              | 2 +-
>  sound/soc/codecs/ad1980.c              | 2 +-
>  sound/soc/codecs/ad73311.c             | 2 +-
>  sound/soc/codecs/adau1373.c            | 2 +-
>  sound/soc/codecs/adau1701.c            | 2 +-

This is difficult to apply against current code as it is a single commit
over lots of files but the ASoC tree has lots of branches.  I've figured
out the dependencies but it's easier to split things up (and avoids
collisions with other changes causing the whole thing to not apply).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/0c7c77c4/attachment.sig>
