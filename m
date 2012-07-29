From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:22:19 +0100
Subject: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no avaiable path found
 for widget kcontrol
In-Reply-To: <1343387941-25266-1-git-send-email-b29396@freescale.com>
References: <1343387941-25266-1-git-send-email-b29396@freescale.com>
Message-ID: <20120729202219.GA4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 07:19:01PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This could help people know what's wrong going on if the required
> path is not registered.

This isn't a good idea, it's fairly common for widgets to have a "None"
option which isn't expected to have an input.
