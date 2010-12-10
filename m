From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Dec 2010 12:36:09 +0000
Subject: [PATCH 8/9] regulators: Removed macros for initialization of
	ab8500 regulators
In-Reply-To: <1291975728-12525-9-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1291975728-12525-9-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101210123609.GH2518@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 11:08:47AM +0100, Bengt Jonsson wrote:
> This patch removes the macros for initializing the regulators.
> The purpose is to remove one layer of abstraction and make the
> code easier to read.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
