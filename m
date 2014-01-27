From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Jan 2014 15:50:27 +0800
Subject: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140127075025.GC4765@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> Changed in v4:
> - Move dma properties from dtsi to dts.

Why this change?  DMA is a SoC level resource rather than board one.

Shawn
