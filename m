From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 12:07:18 -0500
Subject: [PATCH 3/3] mmc: mvsdio: silence card detect notice
In-Reply-To: <1384525354-901-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1384525354-901-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131124170718.GJ29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:22:34PM +0100, Sebastian Hesselbarth wrote:
> mvsdio reports method of card detection with dev_notice, while for
> removable cards it may be sane, for non-removable cards it is not.
> Also, as the user cannot do anything about it, silence the message
> by reducing it from dev_notice to dev_dbg.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/mvsdio.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
