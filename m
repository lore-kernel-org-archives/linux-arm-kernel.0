From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Sep 2013 17:46:00 -0700
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12 (last one)
In-Reply-To: <20130903122449.GF19598@titan.lakedaemon.net>
References: <20130903122449.GF19598@titan.lakedaemon.net>
Message-ID: <CAOesGMjFp9TQMz+ai9z4kLfhOCBLACKjc2SqFbSBy4=qZ3Yw1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 3, 2013 at 5:24 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> Arnd, Olof, Kevin,
>
> Here's the last mvebu/fixes-non-critical pull for v3.12, these came in
> late and have been in -next for about a week.
>
> thx,
>
> Jason.
>
>
> The following changes since commit 35faad2a1563b3d4dc983a82ac41033fe053870c:
>
>   ARM: dts: Fix memory node in skeleton64.dtsi (2013-08-07 16:33:50 +0000)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12-3
>
> for you to fetch changes up to 4e611ae7ef492fd857f64827efda3eea09f75233:
>
>   bus: mvebu: add missing of_node_put() to fix reference leak (2013-08-27 14:33:38 +0000)

These don't seem to apply cleanly, I'm guessing because of the
branches that we deferred to 3.13. If that's the case, then just fold
them in there where appropriate.


-Olof
