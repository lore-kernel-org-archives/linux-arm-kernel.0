From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 12:07:34 +0100
Subject: [PATCH v2 1/4] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20110621110734.GG22177@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 11:07:10AM +0900, MyungJoo Ham wrote:
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This looks good, though you should also be able to make the supply lists
into __initdata.
