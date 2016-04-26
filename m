From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 11:36:37 -0400
Subject: [PATCH 4/7] ARM: dts: lpc32xx: ea3250: add SoC name prefix to
 board dts file
In-Reply-To: <1461631050-10479-5-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
 <1461631050-10479-5-git-send-email-vz@mleia.com>
Message-ID: <1461684997.9433.4.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-26 at 03:37 +0300, Vladimir Zapolskiy wrote:
> To simplify matching of DTS files of all NXP LPC32xx powered boards by
> a file name add 'lpc3250' prefix to Embedded Artists LPC3250 board dts
> file.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/Makefile                           | 3 ++-
>  arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  rename arch/arm/boot/dts/{ea3250.dts => lpc3250-ea3250.dts} (100%)
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
