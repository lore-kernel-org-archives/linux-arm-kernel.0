From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:03:44 -0700
Subject: [GIT PULL 5/5]: ux500 devicetree changes for v3.11
In-Reply-To: <CACRpkdb3sjtPXmbXNPMSreRj_ExHJLEKyv20T8oENTbUTpuARw@mail.gmail.com>
References: <CACRpkdb3sjtPXmbXNPMSreRj_ExHJLEKyv20T8oENTbUTpuARw@mail.gmail.com>
Message-ID: <20130615000344.GF18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:43:21PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here are the ux500 devicetree changes for v3.11. See the signed
> tag for details.
> 
> As mentioned this thing has a merge conflict with pull request 4/5
> (the DMA40 changes) because they both stir around in the
> auxdata population. I would consider merging them into one
> place, like the next/dt branch, but you may have better ideas.
> 
> After this the ux500 device trees actually look like something you
> can feel proud of. We're only missing the clocks for a complete,
> self-contained device tree boot.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
> 
>   Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-dt-for-arm-soc

Pulled. I had a merge conflict that I had to fixup in for-next, please
double check (but it was trivial).


-Olof
