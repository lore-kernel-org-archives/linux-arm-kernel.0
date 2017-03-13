From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Mar 2017 16:06:10 -0700
Subject: [GIT PULL] Gemini device tree and multiplatform conversion
In-Reply-To: <CACRpkdbcJKgk2GzBKQg2zwcrLWVH4=oFQ6bDJ8O-pnhiUUS+Ww@mail.gmail.com>
References: <CACRpkdbcJKgk2GzBKQg2zwcrLWVH4=oFQ6bDJ8O-pnhiUUS+Ww@mail.gmail.com>
Message-ID: <20170313230610.GJ13064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 11:41:54AM +0100, Linus Walleij wrote:
> We now have the driver changes upstream to convert the
> Gemini to device tree and multiplatform in one swift strike.
> 
> I have not included the device tree and bindings in this pull
> request, they will be sent in a follow-on pull request.
> 
> You can merge this separately or with the device tree
> underneath or on top or however you like, what is best for
> your patch flow.
> 
> As there are some new drivers (based on out-of-tree code
> from OpenWRT) we will maybe send more pull requests on
> top of this one for these as they get merged into proper
> subsystems.
> 
> Please pull this into the ARM SoC tree. The DTS pull request
> comes soon after this.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/gemini-multiplat-dt
> 
> for you to fetch changes up to 47d2549ac9be843c7aa1d9472389c644674b218c:
> 
>   ARM: gemini: convert to ARMv4 multiplatform (2017-03-12 11:27:53 +0100)
> 
> ----------------------------------------------------------------
> This patchset:
> 
> - Converts the Gemini platform to device tree.
> - Deletes all the board files.
> - Fixes the prerequisities for a multiplatform boot and
>   switches to multiplatform.

Awesome, thanks for doing this. I've merged this into next/soc since we don't
really track multiplatform changes as a category any more.


-Olof
