From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Sep 2011 09:15:52 -0700
Subject: [PATCH v3] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <1315568332-10224-1-git-send-email-mans.rullgard@linaro.org>
References: <1315568332-10224-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <20110909161551.GC3515@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 12:38:51PM +0100, Mans Rullgard wrote:
> This converts the per-board modules to platform drivers for a
> device created by in main platform setup.  These drivers call
> snd_soc_register_card() directly instead of going via a "soc-audio"
> device and the corresponding driver in soc-core.
> 
> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
