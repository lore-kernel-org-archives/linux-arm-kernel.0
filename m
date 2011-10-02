From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 21:50:09 +0100
Subject: [PATCH 4/6] ASoC: sh: use correct __iomem annotations
In-Reply-To: <1317587284-2776-5-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-5-git-send-email-arnd@arndb.de>
Message-ID: <20111002205008.GB4506@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 10:28:02PM +0200, Arnd Bergmann wrote:
> This removes a few unnecessary type casts and avoids
> sparse warnings.

Applied, thanks.
