From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu, 10 Aug 2017 20:56:35 +0530
Subject: [PATCH 1/2] ASoC: codecs: add const to snd_soc_codec_driver
 structures
In-Reply-To: <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
References: <1501776020-3328-1-git-send-email-bhumirks@gmail.com>
 <1501776020-3328-2-git-send-email-bhumirks@gmail.com>
 <20170810152010.hl2ea5tuyo7mhndf@sirena.org.uk>
Message-ID: <CAOH+1jGe_Xo3o024H4xq8cJV10xta76QmovPKreXpncU86hqFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 8:50 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 03, 2017 at 09:30:19PM +0530, Bhumika Goyal wrote:
>
>>  sound/soc/codecs/88pm860x-codec.c      | 2 +-
>>  sound/soc/codecs/ab8500-codec.c        | 2 +-
>>  sound/soc/codecs/ac97.c                | 2 +-
>>  sound/soc/codecs/ad1836.c              | 2 +-
>>  sound/soc/codecs/ad193x.c              | 2 +-
>>  sound/soc/codecs/ad1980.c              | 2 +-
>>  sound/soc/codecs/ad73311.c             | 2 +-
>>  sound/soc/codecs/adau1373.c            | 2 +-
>>  sound/soc/codecs/adau1701.c            | 2 +-
>
> This is difficult to apply against current code as it is a single commit
> over lots of files but the ASoC tree has lots of branches.  I've figured
> out the dependencies but it's easier to split things up (and avoids
> collisions with other changes causing the whole thing to not apply).

Thanks for the response.
Should I make separate patches for each file or is there another way
to split this patch?

Thanks,
Bhumika
