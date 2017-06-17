From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Jun 2017 19:56:29 +0200
Subject: [PATCH v1 2/2] ARM: dts: rk322x: add spdif node
In-Reply-To: <1496995173-63532-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1496995173-63532-1-git-send-email-sugar.zhang@rock-chips.com>
 <1496995173-63532-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <2530167.bvmFb2R02b@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. Juni 2017, 15:59:33 CEST schrieb Sugar Zhang:
> This patch add spdif node for rk322x.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

applied, after adapting the subject to
	ARM: dts: rockchip: add rk322x spdif node

and dropping the #dma-cells property.
#dma-cells is a property of dma-controllers not dma-clients.


Heiko
