From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 12:48:00 +0000
Subject: [PATCH v2 4/4] ASoC: OMAP: ams-delta: drop .set_bias_level
 callback
In-Reply-To: <1325214296-2888-5-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1325214296-2888-5-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20120102124759.GG4300@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 04:04:56AM +0100, Janusz Krzysztofik wrote:
> This functionality has just been implemented in the cx20442 codec
> driver, no need to keep it here duplicated.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
