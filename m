From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Dec 2010 12:25:48 +0000
Subject: [PATCH 3/9] regulators: Clean out unused code in ab8500 regulators
In-Reply-To: <1291975728-12525-4-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1291975728-12525-4-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101210122548.GC2518@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 11:08:42AM +0100, Bengt Jonsson wrote:
> The find_regulator function was unused so it has been removed. The
> ab8500 pointer in the regulator info structure was unused and so it
> has also been removed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
