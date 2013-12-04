From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 13:39:33 -0800
Subject: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <20131120123152.GZ2674@sirena.org.uk>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <20131017102201.GK2443@sirena.org.uk>
 <52644563.1000203@samsung.com>
 <20131120123152.GZ2674@sirena.org.uk>
Message-ID: <CAOesGMhkEhr0XvTNoObWO4XckUzU1vRiC-ZX2ArcgvSa8-WoQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 4:31 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 21, 2013 at 06:04:35AM +0900, Kukjin Kim wrote:
>
>> Applied this whole series.
>
> This didn't seem to make it into -next or your tree, it'd be really
> helpful to be able to merge into both ASoC and SPI so they can be used
> for some framework work (I already have some patches for ASoC).  Would
> it be possible to get the changes published on a separate branch or
> signed tag so I can pull it into those subsystems for the next merge
> window?

Following up here too: I've merged this branch into arm-soc directly now.


-Olof
