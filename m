From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Oct 2010 13:28:41 -0500
Subject: [PATCH 5/5] ARM: remove per-platform timex.h include files
In-Reply-To: <20101020045200.GB12979@mail.wantstofly.org>
References: <20101020045200.GB12979@mail.wantstofly.org>
Message-ID: <0D753D10438DA54287A00B02708426976450E993CC@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 19, 2010 9:52 PM, Lennert Buytenhek wrote:
>
> As they are now redundant.
>
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---

[snip]

>  arch/arm/mach-ep93xx/include/mach/timex.h     |    5 --

[snip]

>  delete mode 100644 arch/arm/mach-ep93xx/include/mach/timex.h

[snip]

> diff --git a/arch/arm/mach-ep93xx/include/mach/timex.h b/arch/arm/mach-ep93xx/include/mach/timex.h
> deleted file mode 100644
> index 6b3503b..0000000
> --- a/arch/arm/mach-ep93xx/include/mach/timex.h
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -/*
> - * arch/arm/mach-ep93xx/include/mach/timex.h
> - */
> -
> -#define CLOCK_TICK_RATE		983040

For ep93xx.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
