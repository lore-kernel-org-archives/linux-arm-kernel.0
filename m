From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 21:33:59 -0800
Subject: [GIT PULL] omap prcm changes for v3.3 merge window
In-Reply-To: <20111219200046.GS6464@atomide.com>
References: <20111219200046.GS6464@atomide.com>
Message-ID: <CAOesGMiB-Mh-_GvgqPjebVx8VC8Hu6OfvkYkdQoZh6eEiGEWnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:00 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull omap prcm changes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap prcm
>
> These changes adds support for PRCM (Power, Reset, Clock, Module)
> chained interrupt handling. This will eventually allow us to start
> making PM parts into driver modules and move them out of arch/arm.
>
> These are also needed for the serial port runtime PM patches that
> I'll post a pull request for after this.
>
> Note that these have a slight dependency to the previously merged
> omap4 branch so it would produce a minor merge conflict if based
> on something earlier. However, the following uart branch has a
> dependency to both omap4 branch and this branch, so I've based
> this on omap4 branch also.

Thanks, pulled into next/pm.


-Olof
