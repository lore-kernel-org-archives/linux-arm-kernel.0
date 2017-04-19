From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:37:42 -0700
Subject: [GIT PULL] ARM/clk move ICST library to drivers/clk
In-Reply-To: <CACRpkdbPagc3fVyzryRYhcwnQ2WA-z7fSbW+VpR09iLqvVEhjQ@mail.gmail.com>
References: <CACRpkdbPagc3fVyzryRYhcwnQ2WA-z7fSbW+VpR09iLqvVEhjQ@mail.gmail.com>
Message-ID: <20170419133742.GR29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 12:03:16PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this moves the ICST library from arch/arm to drivers/clk
> so it can be reused from there.
> 
> The patches are ACKed by Stephen Boyd.
> 
> Please pull it into some cleanup branch in ARM SoC.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/arm-to-clk-icst
> 
> for you to fetch changes up to ba3fae06c7a4e80ab9d48a8a045b352da97cf23d:
> 
>   ARM/clk: move the ICST library to drivers/clk (2017-04-07 11:58:12 +0200)
> 
> ----------------------------------------------------------------
> This moves the ICST helper library from arch/arm to drivers/clk

We don't have a cleanup branch this release, so I merged this into
next/drivers.

Thanks!


-Olof
