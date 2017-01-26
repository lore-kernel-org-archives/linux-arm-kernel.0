From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Jan 2017 16:28:11 +0100
Subject: [PATCH v4 1/2] power: reset: add linkstation-reset driver
In-Reply-To: <20170119044327.j3d2rlpn5va3iw37@earth> (Sebastian Reichel's
 message of "Thu, 19 Jan 2017 05:43:28 +0100")
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
 <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
 <20170119044327.j3d2rlpn5va3iw37@earth>
Message-ID: <8760l1zvqs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,
 
 On jeu., janv. 19 2017, Sebastian Reichel <sre@kernel.org> wrote:

> Hi Roger,
>
> On Wed, Jan 18, 2017 at 09:08:13PM +0900, Roger Shimizu wrote:
>> On Sun, Jan 8, 2017 at 12:04 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
>> > Buffalo Linkstation / KuroBox and their variants need magic command
>> > sending to UART1 to power-off.
>> >
>> > Power driver linkstation-reset implements the magic command and I/O
>> > routine, which come from files listed below:
>> >   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>> >   - arch/arm/mach-orion5x/terastation_pro2-setup.c
>> 
>> I think there's not much concern regarding to this series.
>> Could you kindly help to apply this patch?
>
> Well you dropped the DT binding, but still introduce new DT
> properties. Since they are not documented without the binding
> I won't merge this. DT binding documentation is not optional.
> In other words: NAK on the binding effectively means NAK on
> the driver in its current state.
>
> If you want to see this merged rebase it to Rob's generic
> serial bindings [0] and help to support him getting everything
> into mainline ASAP. Currently the feedback seems to be quite
> positive, so I hope to see it merged for 4.11.
>
> [0] https://lwn.net/Articles/711794/ (current proposal from 2 days
> ago)

What is te status for your series?

Do you plan sending a new version soon?

Gregory


>
> -- Sebastian
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
