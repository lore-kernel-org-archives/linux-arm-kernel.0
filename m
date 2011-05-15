From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 15 May 2011 16:01:59 -0700
Subject: [PATCH] regulator: mc13892: Fix voltage unit in test case.
In-Reply-To: <1305500025-3602-1-git-send-email-festevam@gmail.com>
References: <1305500025-3602-1-git-send-email-festevam@gmail.com>
Message-ID: <20110515230158.GB18124@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2011 at 07:53:45PM -0300, Fabio Estevam wrote:
> Voltage values should be expressed in microvolts, not in milivolts.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
