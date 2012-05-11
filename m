From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 11 May 2012 06:22:20 +0000
Subject: [PATCH 1/4] ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
In-Reply-To: <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-2-git-send-email-r.sricharan@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
 <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA220F3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 11:46:32, R, Sricharan wrote:
> Vaibhav,
> [snip]
> > Waiting for Paul to conform here.
> >
>  Thanks for pointing that out. Will check on this and Paul's PRCM series
>  cleanup series then.
> 

Sricharan,

Yesterday, Paul confirmed that, removing ifdef is the way to go. So
just few mins back I had submitted patch for the same.

http://permalink.gmane.org/gmane.linux.ports.arm.omap/76972


Thanks,
Vaibhav
