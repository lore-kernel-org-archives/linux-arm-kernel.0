From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 22:56:19 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.1
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <2696940.hV68LRaW1W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 March 2015 09:44:46 Simon Horman wrote:
> * ape6evm board
>   - Configure GPIO keys as wake-up source
>   - Enable pull-up for GPIO switches
>   - Correct polarity of LEDs
> * r8a7791 SoC
>   - Correct IPMMU-GP clock to device tree
> * r8a7794 SoC
>   - Correct ethernet controller PHY IRQ
> * lager, koelsch and marzen boards
>   - Add DU external pixel clock to DT
> * lager board
>   - Add HDMI output support to DT
> * r8a7791 and r8a7790 SoCs
>   - Tidy up SDHI register size in DT
>   - Reference DMA channels for SDHI in DT
> 

Pulled into next/dt, thanks!

	Arnd
