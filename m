From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Dec 2017 13:50:28 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900> <20171213095257.5cf424fb@jawa>
 <CACRpkdaAYLd6ZcBXQP_SfA1dTyyb4kjOpGoW5DUBgH_9pDDtQQ@mail.gmail.com>
Message-ID: <CAK8P3a22-Q6Ksqh3eeoq-iLcs9PA2kZ12Cjp5ibPUKvU8dhbrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 1:33 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Dec 13, 2017 at 9:52 AM, Lukasz Majewski <lukma@denx.de> wrote:

>
> There is a point where supporting old board files will stand in
> the way and cost a lot in maintenance (like moving drivers our
> of arch/arm, or modernizing misc subsystems). Then moving the
> platform over to device tree should be preferred.

I'm generally more interested in the multiplatform conversion than
the DT conversion, and I think converting this one to multiplatform
isn't actually that hard, and doesn't have a significant risk for
regressions, the main work is to convert the clock handling.

       Arnd
