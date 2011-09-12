From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Sep 2011 12:11:49 +0100
Subject: [PATCH v4] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <1315738652-6278-1-git-send-email-mans.rullgard@linaro.org>
References: <1315738652-6278-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <20110912111149.GE2953@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2011 at 11:57:32AM +0100, Mans Rullgard wrote:
> This converts the per-board modules to platform drivers for a
> device created by in main platform setup.  These drivers call
> snd_soc_register_card() directly instead of going via a "soc-audio"
> device and the corresponding driver in soc-core.
> 
> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
