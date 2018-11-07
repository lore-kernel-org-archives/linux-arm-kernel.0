From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 7 Nov 2018 09:17:26 -0800
Subject: [GIT PULL] ARM: SoC fixes
In-Reply-To: <20181107171023.zoo6qox5eewy3pmk@localhost>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
Message-ID: <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
>
> ARM: SoC fixes

Pulled.

> I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> and it ended up regressing at least BeagleBone XM boards.

Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
preempt being off? Otherwise I don't see how/why preempt should fail
in a board-specific manner..

                  Linus
