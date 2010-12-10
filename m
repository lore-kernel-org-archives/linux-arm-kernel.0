From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Dec 2010 12:32:03 +0000
Subject: [PATCH 6/9] regulators: Modified ab8500 error handling
In-Reply-To: <1291975728-12525-7-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1291975728-12525-7-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101210123202.GF2518@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 11:08:45AM +0100, Bengt Jonsson wrote:
> Error handling is updated to catch NULL pointer errors.
> 
> Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

This is also removing an awful lot of unused regulator_id lookups.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
