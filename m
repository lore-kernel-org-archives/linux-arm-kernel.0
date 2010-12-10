From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Dec 2010 12:25:12 +0000
Subject: [PATCH 2/9] regulators: Fixed errors in ab8500 register mapping
In-Reply-To: <1291975728-12525-3-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1291975728-12525-3-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101210122512.GB2518@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 11:08:41AM +0100, Bengt Jonsson wrote:
> For INTCORE and TVOUT regulators, the low power register bit is
> included in the mask so that enable will set the regulator in
> normal (high power) mode.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
