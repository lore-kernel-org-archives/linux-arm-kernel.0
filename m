From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jun 2012 17:42:54 +0200
Subject: How to use ARM ETM/ETB at linux?
In-Reply-To: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
References: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
Message-ID: <CACRpkdZv+Kp0apmLcZQgY07z1YQ3gC8r+d9Ed-c0OZLTo7DN6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 7:38 AM, Frank Li <lznuaa@gmail.com> wrote:

> Anyone use ARM ETM/ETB before?

I know for sure that Arve has been making good use of the ETB+ETB,
since there are some nice patches for it in the Android source tree,
but I don't know how he's using it :-)

John Stultz recently submitted some of Arves patches upstream so let's
ask these gentlemen how they use it.

Yours,
Linus Walleij

>
> I run.
> echo 1 > /sys/devices/etm/trace_running
>
> root at freescale /$ echo v >/proc/sysrq-trigger
> SysRq : etm
> Trace buffer contents length: 4
> --- ETB buffer begin ---
> 01000000000000000000000000000000
>
> --- ETB buffer end ---
>
>
> best regards
> Frank Li

Yours,
Linus Walleij
