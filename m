From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 08:53:07 -0500
Subject: [PATCH v5 2/3] clocksource: orion: Use atomic access for
 shared registers
In-Reply-To: <1386686497-20335-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212135307.GM10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 11:41:36AM -0300, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clocksource/time-orion.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
