From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Mar 2012 22:01:23 -0700
Subject: [GIT PULL] omap fixes for merge window
In-Reply-To: <20120321180536.GK9859@atomide.com>
References: <20120321180536.GK9859@atomide.com>
Message-ID: <CAOesGMiKc5Tc2e5X9=gSiFS87JtMWGmmtOLSStWJcO7ayoE6Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Mar 21, 2012 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Here's a set of fixes that would be nice to get merged during
> the merge window before the GPIO changes get merged to avoid
> boot issues on many omap boards.
>
> The changes queued in the GPIO tree require getting rid of
> OMAP_GPIO_IRQ and use gpio_to_irq() instead. This is needed for
> dynamically allocated GPIO interrupt ranges.

Sorry for the slow response on this, we've been focused on getting the
main pulls going in. I'm about to start a fixes branch now and looked
at this pull request.

I replied to one of the original patches in this branch, they need to
be fixed before they can go in:

http://marc.info/?l=linux-omap&m=133299716528617&w=2

Also, that way we can get a clean branch based on current mainline
without merge conflicts.


-Olof
