From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 30 Aug 2016 14:41:56 +0200
Subject: [RFC PATCH v3 3/5] arm/arm64: vgic-new: Introduce find_reg_by_id()
In-Reply-To: <1472037609-4164-4-git-send-email-vijay.kilari@gmail.com>
References: <1472037609-4164-1-git-send-email-vijay.kilari@gmail.com>
 <1472037609-4164-4-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20160830124156.GI10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 04:50:07PM +0530, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> In order to implement vGICv3 CPU interface access, we will need to perform
> table lookup of system registers. We would need both index_to_params() and
> find_reg() exported for that purpose, but instead we export a single
> function which combines them both.
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
