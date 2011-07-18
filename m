From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jul 2011 18:51:34 +0900
Subject: [PATCH V3 12/13] ASoC: Samsung: Update DMA interface
In-Reply-To: <1310798666-7659-13-git-send-email-kgene.kim@samsung.com>
References: <1310798666-7659-1-git-send-email-kgene.kim@samsung.com>
	<1310798666-7659-13-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110718095133.GC423@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2011 at 03:44:25PM +0900, Kukjin Kim wrote:
> From: Boojin Kim <boojin.kim@samsung.com>
> 
> This patch adds to support the DMA PL330 driver that uses
> DMA generic API. Samsung sound driver uses DMA generic API
> if architecture supports it. Otherwise, use samsung specific
> S3C-PL330 API driver to transfer PCM data.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
