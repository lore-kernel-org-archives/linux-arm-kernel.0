From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 Nov 2011 15:35:58 +0000
Subject: [PATCH] regulator: Use regmap_read/write(), regmap_update_bits
 functions directly
In-Reply-To: <1320621364-25711-1-git-send-email-jhbird.choi@samsung.com>
References: <1320621364-25711-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <20111108153557.GC5632@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 08:16:04AM +0900, jhbird.choi at samsung.com wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Current driver had the regmapcalls within the bodies of the driver specific read/write fuctions.
> This patch removes the original read/write functions and makes the call sites use regmap directly.
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
