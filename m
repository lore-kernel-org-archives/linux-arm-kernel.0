From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Feb 2010 15:57:54 +0000
Subject: [PATCH 3/3] MAINTAINERS: add i2c tree for embedded platforms
In-Reply-To: <1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100228155754.GC16745@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 12:01:46PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Jean Delvare <khali@linux-fr.org>
> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2533fc4..a3c936c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2626,6 +2626,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
>  L:	linux-i2c at vger.kernel.org
>  W:	http://i2c.wiki.kernel.org/
>  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
> +T:	git git://git.fluff.org/bjdooks/linux.git

This is wrong.  This is the same tree which I pull ARM stuff from, so it
needs qualifying with a branch name.
