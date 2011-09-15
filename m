From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 14:32:36 +0100
Subject: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed
	from board files
In-Reply-To: <1316085727-15023-2-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
Message-ID: <20110915133236.GH7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:51:57PM +0530, Rajendra Nayak wrote:
> The TWL driver seems to set the default .valid_modes_mask to
> (REGULATOR_MODE_NORMAL | REGULATOR_MODE_STANDBY) and .valid_ops_mask
> to (REGULATOR_CHANGE_VOLTAGE | REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS)
> for all the registered regulators.
> 
> There is no need for all the board files to pass this information
> additionally, when the driver already sets them by default.

"the driver"?  This sounds very buggy...
