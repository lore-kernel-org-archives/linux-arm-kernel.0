From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 06 Aug 2013 19:58:36 +0100
Subject: [PATCH 2/5] ARM: vexpress/TC2: add Serial Power Controller
 (SPC) support
In-Reply-To: <1375815264-29414-3-git-send-email-pawel.moll@arm.com>
References: <1375815264-29414-1-git-send-email-pawel.moll@arm.com>
 <1375815264-29414-3-git-send-email-pawel.moll@arm.com>
Message-ID: <1375815516.12043.105.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-06 at 19:54 +0100, Pawel Moll wrote:
>  drivers/platform/Kconfig                           |   1 -
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index 69616ae..57811ea 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -4,4 +4,3 @@ endif
>  if GOLDFISH
>  source "drivers/platform/goldfish/Kconfig"
>  endif
> -

I've already noticed and removed that bit.

Pawe?
