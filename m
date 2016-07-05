From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Jul 2016 17:22:22 +0200
Subject: [PATCH 03/11] ASoC: ab8500-codec: remove platform data based probe
In-Reply-To: <20160705134445.GV6247@sirena.org.uk>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <1467722710-1577-3-git-send-email-linus.walleij@linaro.org>
 <20160705134445.GV6247@sirena.org.uk>
Message-ID: <CACRpkdZ7JW7iBzwL_7cY928Fp+CUNwPHQ6D8--CXvoLq7LMZAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 3:44 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 05, 2016 at 02:45:02PM +0200, Linus Walleij wrote:
>
>> Mark: if this makes sense to you, please provide an ACK so Arnd
>> can merge this cleanup.
>
> I'm still not clear what dependency this has on anything elsein the
> series.

None whatsoever if I'm reading it right. The series also compiles
fine without it.

Do you prefer to apply it to the ASoC tree? I can drop
it from this series.

Yours,
Linus Walleij
