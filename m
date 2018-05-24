From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 24 May 2018 11:31:31 +0200
Subject: [PATCH v2] PM / AVS: rockchip-io: add io selectors and supplies
 for PX30
In-Reply-To: <1899248.qiidGlqZWz@phil>
References: <1526384899-11644-1-git-send-email-david.wu@rock-chips.com>
 <1899248.qiidGlqZWz@phil>
Message-ID: <2673153.vuZoQPqmHn@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 15, 2018 1:51:26 PM CEST Heiko Stuebner wrote:
> Hi David,
> 
> Am Dienstag, 15. Mai 2018, 13:48:19 CEST schrieb David Wu:
> > This adds the necessary data for handling io voltage domains on PX30.
> > As interesting tidbit, the PX30 contains two separate iodomain areas.
> > One in the regular General Register Files (GRF) and one in PMUGRF in the
> > pmu power domain.
> > 
> > Signed-off-by: David Wu <david.wu@rock-chips.com>
> 
> thanks for the fast respin, looks great now.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied, thanks!
