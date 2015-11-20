From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 20 Nov 2015 20:25:14 +0100 (CET)
Subject: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
In-Reply-To: <CALAqxLVLQLaAq7fPwJnyOWP_dXV39Dh+QreecxSVY35wi=N0Og@mail.gmail.com>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com>
 <564F570C.7030409@oracle.com> <564F67ED.9000905@ti.com>
 <CALAqxLVLQLaAq7fPwJnyOWP_dXV39Dh+QreecxSVY35wi=N0Og@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1511202021330.3931@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, John Stultz wrote:
> So its unlikely that the hardware both stays running through suspend,
> but also might halt in idle. That would be "unique".

The amount of creativity put into the next variants of differently
broken timers is amazing. So I wouldn't be too surprised if such a
thing actually surfaces.

Thanks,

	tglx
