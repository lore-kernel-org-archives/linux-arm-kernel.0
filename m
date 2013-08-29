From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 19:36:38 +0200
Subject: [alsa-devel] [PATCH 09/18] ASoC: Samsung: Do not queue cyclic
 buffers multiple times
In-Reply-To: <20130829163611.GL10783@sirena.org.uk>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
 <20130829163611.GL10783@sirena.org.uk>
Message-ID: <CACRpkdavSeiraVhjdaitLxBg+RE8h+N33uvddaCQGRcoui7=5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 6:36 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Aug 11, 2013 at 07:59:21PM +0200, Tomasz Figa wrote:
>> The legacy S3C-DMA API required every period of a cyclic buffer to be
>> queued separately. After conversion of Samsung ASoC to Samsung DMA
>> wrappers somebody made an assumption that the same is needed for DMA
>> engine API, which is not true.
>
> Applied, thanks.

OK Vinod can you take in patch 1 thru 8?

Yours,
Linus Walleij
