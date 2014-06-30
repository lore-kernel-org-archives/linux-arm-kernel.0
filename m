From: tj@kernel.org (Tejun Heo)
Date: Mon, 30 Jun 2014 10:49:12 -0400
Subject: [PATCH 13/17] ata: pata_samsung_cf: removes s5pc100 related ata
 codes
In-Reply-To: <1404163947-3105-14-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-14-git-send-email-kgene.kim@samsung.com>
Message-ID: <20140630144912.GE14807@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 06:32:23AM +0900, Kukjin Kim wrote:
> This patch removes support for s5pc100 ata because of no more support
> S5PC100 SoC in mainline.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tejun Heo <tj@kernel.org>

Applied to libata/for-3.17.

Thanks.

-- 
tejun
