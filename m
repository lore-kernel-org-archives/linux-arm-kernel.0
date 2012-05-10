From: b32955@freescale.com (Huang Shijie)
Date: Thu, 10 May 2012 10:51:20 +0800
Subject: Bug in v7_coherent_kern_range() ?
In-Reply-To: <20120411102437.GE16643@mudshark.cambridge.arm.com>
References: <4F77C9A6.6080601@freescale.com>
 <20120402111240.GG19011@mudshark.cambridge.arm.com>
 <4F7E646D.6000302@freescale.com>
 <20120410092214.GA2620@mudshark.cambridge.arm.com>
 <4F840BDC.5060307@freescale.com> <4F854992.9080601@freescale.com>
 <20120411102437.GE16643@mudshark.cambridge.arm.com>
Message-ID: <4FAB2D28.4050800@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will:
> If you still have this problem with a newer kernel, we can try using the
> fallback SMP futex implementation and see if that works.
>
After we update our application(gstreamer), the futex issue gone.
So this is not a kernel bug, but an application bug.

thanks for your help.

Huang Shijie
