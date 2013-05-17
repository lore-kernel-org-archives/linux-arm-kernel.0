From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 17 May 2013 09:51:40 +0200
Subject: [GIT PULL v2] MFD: Fixes due for the v3.10 -rc:s
In-Reply-To: <20130516224337.GZ22822@zurbaran>
References: <20130514091956.GG3297@gmail.com> <20130515090449.GA3494@gmail.com>
 <20130516224337.GZ22822@zurbaran>
Message-ID: <20130517075140.GA25077@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Samuel,

On Fri, May 17, 2013 at 12:43:37AM +0200, Samuel Ortiz wrote:
> > Fabio Baltieri (5):
> >       mfd: abx500-core: Fix sparse warning
> >       mfd: ab8500-sysctrl: Fix sparse warning
> >       mfd: ab8500-sysctrl: Set sysctrl_dev during probe
> >       mfd: ab8500-sysctrl: Let sysctrl driver work without pdata
> Unless I'm missing something here, this one is not really rcN material, so
> I'd appreciate if you could queue it to your for-mfd branch instead.

The last two:

  mfd: ab8500-sysctrl: Set sysctrl_dev during probe
  mfd: ab8500-sysctrl: Let sysctrl driver work without pdata

are actually fixes for bugs introduced in this merge window that
inhibited the ab8500-sysctl driver as a consequence.  Would you
reconsider pulling just those?

Thanks,
Fabio

-- 
Fabio Baltieri
