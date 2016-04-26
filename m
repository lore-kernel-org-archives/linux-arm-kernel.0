From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 11:41:44 -0400
Subject: [PATCH 3/7] ARM: dts: lpc32xx: ea3250: fix Atmel at24 eeprom
 vendor
In-Reply-To: <1461631050-10479-4-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
 <1461631050-10479-4-git-send-email-vz@mleia.com>
Message-ID: <1461685304.9433.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-04-26 at 03:37 +0300, Vladimir Zapolskiy wrote:
> There is no 'at' hardware vendor defined yet, correct vendor prefix
> for Atmel is 'atmel'.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/boot/dts/ea3250.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
