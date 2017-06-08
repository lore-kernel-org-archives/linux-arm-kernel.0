From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Jun 2017 23:55:47 +0200
Subject: [PATCH] ARM: dts: sama5d2_xplained: remove wrong memory node
In-Reply-To: <04c9a65854a644958ebabf10d97359021b947cb4.1496033479.git.baruch@tkos.co.il>
References: <04c9a65854a644958ebabf10d97359021b947cb4.1496033479.git.baruch@tkos.co.il>
Message-ID: <20170608215547.g7hpwq7ydpzzgwyr@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/2017 at 07:51:19 +0300, Baruch Siach wrote:
> The size field of the memory node is wrong. Rely on the default value in
> sama5d2.dtsi that happens to be correct for the SAMA5D2 Xplained board.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
