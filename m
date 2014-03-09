From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Mar 2014 11:45:00 -0700
Subject: [GIT PULL] ux500 devicetree cleanups for v3.15, take two
In-Reply-To: <CACRpkdb4SgZgbgQ6m31LWmqTT7nskaR8yV4OXO9RmvgXhVZPCA@mail.gmail.com>
References: <CACRpkdb4SgZgbgQ6m31LWmqTT7nskaR8yV4OXO9RmvgXhVZPCA@mail.gmail.com>
Message-ID: <20140309184500.GH22881@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 02:12:54AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is a set of cleanups building upon the already submitted cleanups
> queued on the ux500/dt branch in the ARM SoC tree.
> 
> This kills of another three boardfile things with just constants so it's a
> real nice step forward to finalizing ux500 as a DT-only platform.
> 
> Remaining cleanups are a few hardcoded DMA definitions related to
> DMA (that I won't do until I can really test the result) and some MMC
> stuff that first need proper DT support in the MMC subsystem.
> 
> This contains a u300 patch as well, as it is closely related to the same
> ux500 patch and I do not plan to send any separate u300 pull request
> for this kernel cycle.
> 
> So please pull this in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 77ad9dfc2c7e3b5ce49efc5c0c215f7c36c91cf2:
> 
>   ARM: ux500: move last AB8505 set-up to DT (2014-02-04 20:50:55 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-dt-v3.15-2
> 
> for you to fetch changes up to f864c46aae4cb6aed09e98615c427fcc4f1de104:
> 
>   mfd: dbx500/abx500: root out hardcoded IRQ assignments (2014-03-04
> 08:58:11 +0800)

Nice. Pulled into next/dt due to the dependencies.


-Olof
