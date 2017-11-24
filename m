From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Nov 2017 11:04:04 +0100
Subject: [PATCH v2] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
References: <20171107201857.5752-1-linus.walleij@linaro.org>
 <20171110145038.i4jnqsctdzkfmoe5@ninjato>
 <CACRpkdangY192aFpSd1hVaie6A8kY+sASORhR_ncHLYLeUJMWw@mail.gmail.com>
 <CAK8P3a3s-1mD+eVagHBr-YL-nAyr_QN2VZNo7qBn=FZCQfEEkg@mail.gmail.com>
Message-ID: <CACRpkdbrcUOExjRmv5zN1hOvBAT18GOfRw9=5+e3d+MhS3q9+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 4:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I have this in my ~/.gitconfig:
>
> [core]
>         abbrev = 12
> [alias]
>         fixes = show --format='Fixes: %h (\"%s\")' -s
>
> So 'git fixes b2e63555592f81331c8da3afaa607d8cf83e8138' produces
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
>
> which I then copy into a changelog as the last line, or use only the reference.

That's a neat trick.

I stole it :)

Yours,
Linus Walleij
