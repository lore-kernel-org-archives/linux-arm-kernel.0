From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 17:46:34 -0800
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.10
In-Reply-To: <CAK7LNAQ5_Sc99WbTWR9u3_J0FqG8KUSGNQzggdQC91Cngxi+Cw@mail.gmail.com>
References: <CAK7LNAQ5_Sc99WbTWR9u3_J0FqG8KUSGNQzggdQC91Cngxi+Cw@mail.gmail.com>
Message-ID: <20161118014634.GK8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 06, 2016 at 12:18:11AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (32bit) updates for the v4.10 merge window.
> Please pull!
> 
> (This time, I based this pull-request on -rc3 instead of -rc1
> because I want to make sure to have no conflict
> between fixes that had already been pulled-in and
> new development commits in this series.)

What you can do is instad use your fixes branch as base, since in this
case we had -rc2 as our base for next/dt. Since you based on -rc3, we need
to bring in a newer upstream revision (a backmerge), and that's something we
try to avoid.

I've merged your branch in this case anyway, but next time try basing on top
of your fixes if you need to.


Thanks!


-Olof
