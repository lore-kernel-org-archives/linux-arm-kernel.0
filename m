From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:02:04 -0700
Subject: [GIT PULL 2/5]: ux500 clocksource changes for v3.11
In-Reply-To: <CACRpkdbPBvEU0V29YCqL6Tp0XGbjfJebrZu1TZ_4OFkjB9dMww@mail.gmail.com>
References: <CACRpkdbPBvEU0V29YCqL6Tp0XGbjfJebrZu1TZ_4OFkjB9dMww@mail.gmail.com>
Message-ID: <20130615000204.GC18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:23:21PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is the ux500 clocksource changes for v3.11. See the signed
> tag for details.
> 
> The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:
> 
>   Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-clksrc-for-arm-soc
> 
> for you to fetch changes up to 807eba55f73e98b76d0afdc197d942c46122bdca:
> 
>   clocksource: dbx500-prcmu: comment cleanup (2013-05-27 14:05:54 +0200)
> 
> ----------------------------------------------------------------
> Ux500 clocksource updates:
> - Use relaxed readl() variant
> - Fix a single comment
> 
> ----------------------------------------------------------------
> Fabio Baltieri (1):
>       clocksource: dbx500-prcmu: comment cleanup
> 
> Rabin Vincent (1):
>       clocksource: dbx500-prcmu: use relaxed readl variant
> 
>  drivers/clocksource/clksrc-dbx500-prcmu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Pulled.


-Olof
