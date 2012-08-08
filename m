From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 14:35:40 +0100
Subject: [PATCH v2 3/4] regulator: add a new API
 regulator_set_voltage_tol()
In-Reply-To: <1344179121-17738-4-git-send-email-shawn.guo@linaro.org>
References: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
 <1344179121-17738-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120808133540.GB16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 11:05:20PM +0800, Shawn Guo wrote:
> There are some use cases where a voltage range could be reasonably
> specified by a target voltage and tolerance.  Add a new API
> regulator_set_voltage_tol() wrapping regulator_set_voltage() call
> to ease the users.

Applied, thanks!  It's on a separate branch so can easily be either
applied somewhere else or merged into another tree if required for
dependencies, just let me know.
