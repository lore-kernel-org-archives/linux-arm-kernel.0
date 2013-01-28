From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 13:35:49 -0800
Subject: [GIT PULL] U300-related COH901318 cleanup
In-Reply-To: <CACRpkdZtWwHwvfNrSjZiY0Dn7qnk34R9ZSpLfH_VRhGzVEWpKQ@mail.gmail.com>
References: <CACRpkdZtWwHwvfNrSjZiY0Dn7qnk34R9ZSpLfH_VRhGzVEWpKQ@mail.gmail.com>
Message-ID: <20130128213549.GB3047@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 02:59:58PM +0100, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> This pushes the platform data for the COH901318 DMA controller down
> into the driver so it is self-contained as a cleanup for the U300 machine.
> 
> Since roughly 50% of this patch affects arch/arm/mach* and we may want
> to build additional cleanups on top, we need to take this into the ARM
> SoC tree.
> 
> All patches are ACKed by the DMA subsystem maintainer.
> 
> Please pull it into ARM SoC!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
> 
>   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/coh901318-for-arm-soc


Thanks, pulled into next/drivers.


-Olof
