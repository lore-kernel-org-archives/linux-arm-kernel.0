From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 08:53:42 -0500
Subject: [PATCH v5 3/3] watchdog: orion: Use atomic access for shared
 registers
In-Reply-To: <1386686497-20335-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212135342.GN10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:41:37AM -0300, Ezequiel Garcia wrote:
> Since the timer control register is shared with the clocksource driver,
> use the recently introduced atomic_io_clear_set() to access such register.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
