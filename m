From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 21:48:53 +0100
Subject: [PATCH 6/6] ASoC: samsung: add missing __devexit_p() annotations
In-Reply-To: <1317587284-2776-7-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-7-git-send-email-arnd@arndb.de>
Message-ID: <20111002204852.GD5811@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 10:28:04PM +0200, Arnd Bergmann wrote:
> Drivers that refer to a __devexit function in an operations
> structure need to annotate that pointer with __devexit_p so
> replace it with a NULL pointer when the section gets discarded.

Again Axel already fixed these (and the other Samsung CPU drivers).
