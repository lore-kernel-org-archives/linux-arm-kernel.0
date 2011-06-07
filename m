From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Jun 2011 14:05:35 +0530
Subject: [PATCH 1/3] gpio/spear-plgpio: Add plgpio driver for SPEAr
	platform
In-Reply-To: <20110603175020.GD15616@ponder.secretlab.ca>
References: <cover.1306737135.git.viresh.kumar@st.com>
	<385c65f02831af2a16bcd4ea56c22ce6d8747ef0.1306737135.git.viresh.kumar@st.com>
	<20110603175020.GD15616@ponder.secretlab.ca>
Message-ID: <4DEDE2D7.6030100@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2011 11:20 PM, Grant Likely wrote:
> On Mon, May 30, 2011 at 12:09:02PM +0530, Viresh Kumar wrote:
>> > Plgpio pads on few spear machines can be configured as gpios. This patch adds
>> > support for configuring these PLGPIOs.
>> >
>> > This was earlier posted & reviewed as part of arch/arm/plat-spear/ code.
>> >
>> > Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
>> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> This ends up being yet-another-mmio-gpio implementation.  Please look
> at bgpio_init() in drivers/basic_mmio_gpio.c.  This driver should be
> refactored to use that.

Ok. Will check that.

-- 
viresh
