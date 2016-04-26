From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 11:46:20 -0400
Subject: [PATCH 5/7] ARM: dts: lpc32xx: phy3250: avoid extension of
 device nodes by absolute path
In-Reply-To: <1461631050-10479-6-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
 <1461631050-10479-6-git-send-email-vz@mleia.com>
Message-ID: <1461685580.9433.8.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-26 at 03:37 +0300, Vladimir Zapolskiy wrote:
> The change simplifies layout of PHY3250 board description by
> referencing device nodes of LPC32xx controllers by label.
> 
> No functional change intended.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/phy3250.dts | 282 +++++++++++++++++++++---------------------
>  1 file changed, 138 insertions(+), 144 deletions(-)
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
