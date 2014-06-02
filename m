From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 2 Jun 2014 19:07:59 +0200
Subject: [GIT PULL] at91: drivers for 3.16 #1
In-Reply-To: <CAOesGMj1FuozbydRf=J7jWFt_8GZ8ZKZReg_1BmvPC706cZ7rQ@mail.gmail.com>
References: <1401726901-19093-1-git-send-email-nicolas.ferre@atmel.com>
 <CAOesGMj1FuozbydRf=J7jWFt_8GZ8ZKZReg_1BmvPC706cZ7rQ@mail.gmail.com>
Message-ID: <20140602170758.GA17518@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/06/2014 at 09:37:01 -0700, Olof Johansson wrote :
> On Mon, Jun 2, 2014 at 9:35 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > Arnd, Olof, Kevin,
> >
> > Here is an additional AT91 pull-request for 3.16 about drivers and
> > particularly focused on PWM.
> > Alexandre did a great job replacing the existing calls to the older,
> > non-standard drivers by the use of the newer "pwm-atmel" which takes
> > advantage of the PWM framework.
> > In addition of removing three obsolete drivers, it also solves an issue with
> > non existing Kconfig symbols introduced by (misc: atmel_pwm: only build for
> > supported platforms) which was trying to avoid a build failure... so, all in
> > all, a pretty good thing!
> >
> > The drawback is that this series depends on two git trees:
> >
> > Obviously, one from Thierry:
> > git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> >
> > And as well the one from Greg who took Arnd's patch for Kconfig:
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> >
> > Tell me if you feel it is the proper way to deal with this or if it is too late
> > for this round (look at the diffstat, yummy ;-))
> >
> > Thanks, best regards,
> >
> > The following changes since commit fa264e615338c423e344d34621f992858b957097:
> >
> >   Merge branch 'char-misc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc into at91-3.16-drivers (2014-06-02 18:02:18 +0200)
> >
> > are available in the git repository at:
> >
> >
> >   git://github.com/at91linux/linux-at91.git tags/at91-drivers
> 
> The 3.16 merge window is open, please resend after -rc1.
> 

Hopefully, this will solve our dependency issues :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
