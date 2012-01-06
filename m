From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 Jan 2012 11:01:26 -0800
Subject: [PATCH v2 1/1] regulator: set constraints.apply_uV to 0 in
 of_get_fixed_voltage_config
In-Reply-To: <1325646449-21916-1-git-send-email-richard.zhao@linaro.org>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <1325646449-21916-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120106190124.GE2893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 11:07:29AM +0800, Richard Zhao wrote:
> Fix fixed regulator using DT failed to call regulator_register.
> 
> of_get_regulator_init_data set apply_uV to 1, but fixed regulator
> doesn't need it. Set it back to 0.

Applied, thanks.
