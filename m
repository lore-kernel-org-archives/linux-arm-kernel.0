From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 28 Nov 2011 13:53:11 +0530
Subject: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
In-Reply-To: <87obwsg9ua.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
 <87obwsg9ua.fsf@ti.com>
Message-ID: <CAC83ZvKJRxGK-j16Yj9A60rSPNNV-4MMxUd9f7w7n-KJr2R+VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>
> Using this series on 3630/Zoom3, UART wakeups no longer work from
> suspend. ?That suggests that GPIO wakeups from retention/off are not
> working.
>
> Please test GPIO wakeups from retention/off. ?One way is to use Zoom3
> UART wakeup from suspend using by enabling UART wakeups and suspending:
>
> ? # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
> ? # echo mem > /sys/power/state
>
> Also, this series now has a handful of minor conflicts with stuff that
> is queued or merged for v3.2. ?Please rebase onto
>
> ? git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base
I am not seeing for_3.3/gpio-base branch anymore.
Is there an alternate branch where I can post the patch?
--
Tarun
>
> Kevin
>
