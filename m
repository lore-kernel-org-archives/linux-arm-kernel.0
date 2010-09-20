From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Sep 2010 14:03:44 +0100
Subject: [PATCHv2 7/7] ARM: S5PC110: add support for MMC regulators on
	Goni board
In-Reply-To: <1284987337-15365-8-git-send-email-m.szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
	<1284987337-15365-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100920130344.GC31167@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 02:55:37PM +0200, Marek Szyprowski wrote:
> Add required platform definitions for MMC power regulators on Samsung
> Goni board. GPIO pin GONI_EXT_FLASH_EN has been transferred from machine
> startup code to fixed voltage regulator.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks good from a regulator API point of view:

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
