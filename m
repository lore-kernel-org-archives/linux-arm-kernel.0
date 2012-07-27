From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2012 17:19:15 -0700
Subject: [GIT PULL] OMAP4 coupled CPUidle support for v3.6
In-Reply-To: <87394enqz8.fsf@ti.com>
References: <87394enqz8.fsf@ti.com>
Message-ID: <CAOesGMiTfW6Qz=z4FvG=SomCuKo3C8um1M=uXJV8ZAjeKhRoOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Thu, Jul 26, 2012 at 2:37 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Arnd, Olof,
>
> I know it is late, but I'm really hoping this can still make it for
> v3.6, so consider this a [GIT PLEA].  ;)

New features submitted halfway through the merge window? Yeah, that's late.

I'll pull it in as late2/pm once the below is fixed, but I won't
promise we'll send it up.


> Kevin Hilman (1):
>       ARM: OMAP4: CPUidle: add synchronization for coupled idle states
>
> Santosh Shilimkar (3):
>       ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
>       ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
>       ARM: OMAP4: CPUidle: Open broadcast clock-event device.

This looks odd, Colin was author to the first of the commits
attributed to Santosh.


-Olof
