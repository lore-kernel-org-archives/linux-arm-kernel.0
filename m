From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 10:25:10 +0200
Subject: [GIT PULL v2] MFD: Fixes due for the v3.10 -rc:s
In-Reply-To: <20130517075140.GA25077@balto.lan>
References: <20130514091956.GG3297@gmail.com> <20130515090449.GA3494@gmail.com>
 <20130516224337.GZ22822@zurbaran>
 <20130517075140.GA25077@balto.lan>
Message-ID: <CACRpkdYpEreHKdUyfcANA9kTRAjVbLbpJkBJCq1Q_pAeOKcdxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 9:51 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> Hello Samuel,
(...)
> The last two:
>
>   mfd: ab8500-sysctrl: Set sysctrl_dev during probe
>   mfd: ab8500-sysctrl: Let sysctrl driver work without pdata
>
> are actually fixes for bugs introduced in this merge window that
> inhibited the ab8500-sysctl driver as a consequence.  Would you
> reconsider pulling just those?

A good way to make sure that patches fixing regressions are applied
to the -rc series is to indicate in the commit message or even the
heading that it fixes a regression.

I usually try to begin such commits with the text:

  this patch fixes a regression caused by change 018745435
  "foo: fix bar"...

Then copying in some crash dump text never hurts :-)

It makes it very easy for us as subsystem maintainers to pick
regression fixes.

Yours,
Linus Walleij
