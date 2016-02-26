From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 25 Feb 2016 19:45:15 -0800
Subject: [PATCH 50/50] pinctrl: zynq: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-51-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-51-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160226034515.GA3173@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-02-24 at 18:46:15 +0530, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and
> remove the need of .remove callback.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
