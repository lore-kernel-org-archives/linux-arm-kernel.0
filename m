From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 05 Aug 2015 10:14:40 -0700
Subject: [PATCH 1/2] MAINTAINERS: Add myself as a bcm2835 co-maintainer.
In-Reply-To: <1437594937-28583-1-git-send-email-eric@anholt.net>
References: <1437594937-28583-1-git-send-email-eric@anholt.net>
Message-ID: <55C24480.7080102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 12:55, Eric Anholt wrote:
> The current maintainers have limited free time to work on the
> architecture, and I'm motivated to do so for my work on graphics for
> Broadcom.  Arnd and Florian suggested to me that this might be the way
> forward.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Applied to maintainers/next with Stephen's Ack at
github.com/Broadcom/stblinux, will submit this shortly with other
Broadcom SoC changes, thanks!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d55c..1c51379 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2217,6 +2217,7 @@ F:	drivers/clocksource/bcm_kona_timer.c
>  BROADCOM BCM2835 ARM ARCHITECTURE
>  M:	Stephen Warren <swarren@wwwdotorg.org>
>  M:	Lee Jones <lee@kernel.org>
> +M:	Eric Anholt <eric@anholt.net>
>  L:	linux-rpi-kernel at lists.infradead.org (moderated for non-subscribers)
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
>  S:	Maintained
> 


-- 
Florian
