From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 14:51:38 +0100
Subject: [RFC PATCH 07/11] regulator: Make fixed regulator driver extract
	data from DT
In-Reply-To: <1316085727-15023-8-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<1316085727-15023-8-git-send-email-rnayak@ti.com>
Message-ID: <20110915135137.GM7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:52:03PM +0530, Rajendra Nayak wrote:
> Modify the fixed regulator driver to extract fixed_voltage_config from
> device tree when passed, instead of getting it through platform_data
> structures (on non-DT builds)

The code you added in the previous patch should be part of this driver.
