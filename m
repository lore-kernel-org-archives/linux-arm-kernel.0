From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Sep 2010 09:04:30 -0700
Subject: [PATCH v3 3/5] mfd: regulator: max8998: BUCK1/2 internal
	voltages and indexes defined
In-Reply-To: <1285590747-32404-4-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
	<1285590747-32404-4-git-send-email-l.majewski@samsung.com>
Message-ID: <20100927160429.GG13754@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 02:32:25PM +0200, Lukasz Majewski wrote:
> BUCK1/2 internal voltages and indexes defined in the struct max8998_data
> max_get_voltage_register now uses index values to chose proper register
> More generic BUCK1/2 registers names provided
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
