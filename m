From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Jun 2013 11:22:55 -0700
Subject: [GIT PULL] ux500 DMA40 fixes for next/drivers
In-Reply-To: <CACRpkdY_RyTW1kEUpUKbP9hpt-9pvG=e00mCMDvr5fyYuQFU7g@mail.gmail.com>
References: <CACRpkdY_RyTW1kEUpUKbP9hpt-9pvG=e00mCMDvr5fyYuQFU7g@mail.gmail.com>
Message-ID: <20130625182255.GF10694@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 03:11:55PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here are some fixes for the DMA40 patch stack that is currently
> boiling in next/drivers. They are of such type that they can go in
> per immediately or at -rc1.
> 
> I tested to merge this into next/drivers and it seems to go in
> smoothly.
> 
> Please pull it in at your convenience.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 499c2bc3cc89dcbbf08aa526cd4a984b92a4d2a8:
> 
>   dmaengine: ste_dma40: Fetch disabled channels from DT (2013-06-04
> 11:12:12 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-dma40-for-arm-soc-3


Merged into next/drivers on top of the other branches.


-Olof
