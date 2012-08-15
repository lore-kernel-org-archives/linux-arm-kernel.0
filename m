From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Aug 2012 15:01:17 +0100
Subject: [PATCH 03/22] ASoC: ab8500: Inform SoC Core that we have our own
 I/O arrangements
In-Reply-To: <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20120815140117.GC13544@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 04:47:29PM +0100, Lee Jones wrote:
> If codec->control_data is not populated SoC Core assumes we want to
> use regmap, which fails catastrophically, as we don't have one:

*Always* submit code against the current code for the subsystem.
