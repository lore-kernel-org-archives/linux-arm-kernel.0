From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 19 Apr 2016 13:52:33 -0500
Subject: [PATCH 3/4] soc: qcom: spm: use const and __initconst for
 qcom_cpuidle_ops
In-Reply-To: <1458657763-2561-4-git-send-email-jszhang@marvell.com>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
 <1458657763-2561-4-git-send-email-jszhang@marvell.com>
Message-ID: <20160419185233.GB9967@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 10:42:42PM +0800, Jisheng Zhang wrote:
> The qcom_cpuidle_ops structures is not over-written, so add "const"
> qualifier and replace __initdata with __initconst.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Andy Gross <andy.gross@linaro.org>
