From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 13:51:26 +0200
Subject: [PATCH v2] PM / AVS: rockchip-io: add io selectors and supplies
 for PX30
In-Reply-To: <1526384899-11644-1-git-send-email-david.wu@rock-chips.com>
References: <1526384899-11644-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1899248.qiidGlqZWz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Dienstag, 15. Mai 2018, 13:48:19 CEST schrieb David Wu:
> This adds the necessary data for handling io voltage domains on PX30.
> As interesting tidbit, the PX30 contains two separate iodomain areas.
> One in the regular General Register Files (GRF) and one in PMUGRF in the
> pmu power domain.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

thanks for the fast respin, looks great now.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
