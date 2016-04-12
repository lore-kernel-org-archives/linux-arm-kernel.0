From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Apr 2016 04:23:14 +0200
Subject: [PATCH v2 1/5] PM / AVS: rockchip-io: make io-domains a child of
 the GRF
In-Reply-To: <1459432126-6395-2-git-send-email-heiko@sntech.de>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de>
 <1459432126-6395-2-git-send-email-heiko@sntech.de>
Message-ID: <3991738.xMQYlxyb28@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Am Donnerstag, 31. M?rz 2016, 15:48:42 schrieb Heiko Stuebner:
> IO-domain handling is part of the general register files, so should live
> under the grf directly. This change allows the grf to be a simple-mfd and
> the io-domains fetching the syscon regmap from that parent-node.
> 
> The old binding is of course preserved, though deprecated.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: David Wu <david.wu@rock-chips.com>

could you look into picking up this patch 1/5 please?

The others are to much interwined into other devicetree changes, so I'll 
apply them for 4.8, but it would be nice if you could pick up this one for 
4.7 so the code change becomes available at 4.8-rc1


Thanks
Heiko
