From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 3 Apr 2017 10:54:31 +0300
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
Message-ID: <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 3, 2017 at 12:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Sun, 2 Apr 2017, Andi Kleen wrote:
>> No PTYs seems like a big limitation. This means no sshd?

> Again, my ultimate system target is in the sub-megabyte of RAM.  I
> really doubt you'll be able to fit an SSH server in there even if PTYs
> were supported, unless sshd (or dropbear) can be made really tiny.

Are you sure you need Linux there? There is a nice Zephyr project
(OpenSource RTOS, POSIX compatible) exactly for microcontrollers.

While I can agree on making Linux stuff less fatty, I can't agree on
doing this way. We have for now two subsystems to serve for serial
devices, you are proposing third one for only narrow class of devices.
>From my point of view is better to achive your goal with existing
system (as a proof of concept maybe even with ugly #ifdef:fery).

-- 
With Best Regards,
Andy Shevchenko
