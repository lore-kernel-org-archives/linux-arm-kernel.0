From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 17 Feb 2015 09:41:09 -0800
Subject: [GIT PULL 5/7] ARM: SoC driver updates
In-Reply-To: <1424162008-23768-6-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
 <1424162008-23768-6-git-send-email-olof@lixom.net>
Message-ID: <CA+55aFz1i4M4GYOpPp4UAQPGx7b0PTd9Uv0gctU6EMKe3kb4wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 12:33 AM, Olof Johansson <olof@lixom.net> wrote:
>
> Conflicts:
>
> arch/arm/boot/dts/rk3288.dtsi:  add/add: Keep both sides
...

You mixed up the aliases of this pull and the previous DT pull.

Not a real problem, but while resolving the DT aliases (which you
claimed had "No conflicts") I was wondering just what you had been
doing..

                       Linus
