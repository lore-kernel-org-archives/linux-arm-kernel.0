From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 20 Dec 2010 10:30:17 +0100
Subject: [PATCH 01/11] ARM: Add SZ_128
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD788B5@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-2-git-send-email-swarren@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD788B5@HQMAIL01.nvidia.com>
Message-ID: <20101220093017.GS1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 04:04:42PM -0800, Stephen Warren wrote:
> Sorry, resending this so that it reaches the ARM kernel mailing list; I
> used an old address last time around.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> CC: linux-arm at lists.arm.linux.org.uk
... and it's still there

> ---
>  arch/arm/include/asm/sizes.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/sizes.h b/arch/arm/include/asm/sizes.h
> index 4fc1565..98348c3 100644
> --- a/arch/arm/include/asm/sizes.h
> +++ b/arch/arm/include/asm/sizes.h
> @@ -25,6 +25,7 @@
> 
>  /* handy sizes */
>  #define SZ_16				0x00000010
> +#define SZ_128				0x00000080
I don't know about your motivation, but why not add all missing entries
(and remove the DO NOT EDIT!! statement in the header (and the wrong
address of the FSF))?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
