From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Aug 2013 22:10:08 -0300
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
In-Reply-To: <CAOesGMh1=qSDv=dohW=DOLbYS0YJYnYs=7rZB-mpZTBtPWLsYw@mail.gmail.com>
References: <51FBF93D.8040707@arm.com> <20130804122527.GV3880@pengutronix.de>
 <CAOesGMgnYLXRWRtKckofNpsxmRgT0cXL=JcAMirXibe92+AWOQ@mail.gmail.com>
 <20130806234419.GC15014@blackmetal.musicnaut.iki.fi>
 <CAOesGMh1=qSDv=dohW=DOLbYS0YJYnYs=7rZB-mpZTBtPWLsYw@mail.gmail.com>
Message-ID: <CAOMZO5CEbXsvdWyr1WqiijWyA-68bFo9iOg1PxBJXorbNe7bBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Aug 6, 2013 at 9:28 PM, Olof Johansson <olof@lixom.net> wrote:

> There's a current build breakage on linux-next for bcm2835_defconfig
> and mxs_defconfig that needs looking at, btw. :)

This issue is fixed by this patch:
http://ozlabs.org/~akpm/mmots/broken-out/watchdog-update-watchdog_tresh-properly-fix.patch
