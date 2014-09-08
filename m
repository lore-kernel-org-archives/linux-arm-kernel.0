From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 8 Sep 2014 20:23:13 +0300
Subject: [PATCH 07/10] ARM: OMAP5 / DRA7: Enable CPU RET on suspend
In-Reply-To: <20140905211558.GA31011@kahuna>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <1408716154-26101-8-git-send-email-nm@ti.com>
 <7hbnr5dake.fsf@paris.lan> <53FE2BF2.3020006@ti.com>
 <20140827194156.GE16006@atomide.com> <53FE34D7.7040004@ti.com>
 <53FE3551.2080806@ti.com> <20140905211558.GA31011@kahuna>
Message-ID: <CANOLnONWPdO80XWOYQatmOh+Ek107fBXDiqD3DpMXeazjLcdMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 6, 2014 at 12:15 AM, Nishanth Menon <nm@ti.com> wrote:
>
> Hi,
>
> Updated patch below:
> Do let me know if this is ok with folks.
>
> ---8<----
> From 1b9e11834dac2bd75c396aa7495c806b027653fe Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Mon, 27 May 2013 15:46:44 +0530
> Subject: [PATCH V2 7/10] ARM: OMAP5 / DRA7: Enable CPU RET on suspend
>
> On OMAP5 / DRA7, prevent a CPU powerdomain OFF and resulting MPU OSWR
> and instead attempt a CPU RET and side effect, MPU RET in suspend.
>
> NOTE: the hardware was originally designed to be capable of achieving
> deep power states such as OFF and OSWR, however due to various issues
> and risks, deepest valid state was determined to be CSWR - hence we use

Would be great to have some more details here..
So there is no hope for OFF mode on OMAP5?


-- 
Gra?vydas
