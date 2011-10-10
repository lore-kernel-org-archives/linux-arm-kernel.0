From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Oct 2011 17:25:07 +0100
Subject: [PATCH v2 1/5] regulator: twl: Remove hardcoded board
	constraints from driver
In-Reply-To: <1318263578-7407-2-git-send-email-rnayak@ti.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-2-git-send-email-rnayak@ti.com>
Message-ID: <20111010162507.GF3607@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 09:49:34PM +0530, Rajendra Nayak wrote:
> Remove the hardcoded .valid_modes_mask and .valid_ops_mask for
> each regulator from the twl driver and let the boards pass it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Please update this changelog - as I said in reply to your previous
posting this isn't actually hardcoding anything, it's dropping things
from the constraints which the hardware doesn't support.
