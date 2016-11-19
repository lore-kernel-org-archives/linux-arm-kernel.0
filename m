From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:41:53 -0800
Subject: [GIT PULL 1/5] non-urgent omap fixes for v4.10
In-Reply-To: <582b7c99.5790620a.e95a2.d641SMTPIN_ADDED_BROKEN@mx.google.com>
References: <582b7c99.5790620a.e95a2.d641SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20161119004153.GD15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 01:22:19PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/fixes-not-urgent-signed
> 
> for you to fetch changes up to 5c02b01d234f8410010c952069d3fb9ec5d9124a:
> 
>   ARM: OMAP2+: pm-debug: Use seq_putc() in two functions (2016-11-09 15:33:33 -0700)
> 
> ----------------------------------------------------------------
> Non-urgent fixes for omaps for v4.10 merge window:
> 
> - Fix mismatched interrupt numbers for tps65217, these are not yet
>   used
> 
> - Remove unused omapdss_early_init_of()
> 
> - Use seq_putc() for pm-debug.c

Merged, thanks.


-Olof
