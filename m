From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Oct 2015 15:24:51 +0200
Subject: [PATCH 3/3] ARM: at91/defconfig: update sama5 defconfig
In-Reply-To: <1444824684-24526-3-git-send-email-ludovic.desroches@atmel.com>
References: <1444824684-24526-1-git-send-email-ludovic.desroches@atmel.com>
 <1444824684-24526-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20151015132451.GD3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/10/2015 at 14:11:24 +0200, Ludovic Desroches wrote :
> Add SAMA5D2 SoC plus Atmel flexcom and Atmel sdhci devices.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/configs/sama5_defconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
It is probably worth updating the multi_v7_defconfig too (in a separate
patch).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
