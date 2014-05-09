From: nm@ti.com (Nishanth Menon)
Date: Fri, 9 May 2014 07:33:47 -0500
Subject: omap4-panda-es boot issues with v3.15-rc4
In-Reply-To: <536C9208.6000704@ti.com>
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan>
 <CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>
 <536BBAF5.8070906@ti.com> <536C9208.6000704@ti.com>
Message-ID: <CAGo_u6rz96boeCFjLTjuJ185ru=xOuz6__y-wMpwphcXu32Wsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 9, 2014 at 3:30 AM, Roger Quadros <rogerq@ti.com> wrote:
>
> Stupid question, is hearbeat LED even supposed to stop blinking in C3 state?
> It would make a user think that the board is dead.

I believe yes - we have tick suppression. else we'd be just wasting
power by waking up just to blink an LED. some deeper C states need
higher latencies.

Regards,
Nishanth Menon
