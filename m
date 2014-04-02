From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Apr 2014 18:00:34 +0100
Subject: [PATCH 1/2] ARM: hisi: enable L2 driver
In-Reply-To: <1396445663-1357-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396445663-1357-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140402170034.GK7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 09:34:22PM +0800, Haojian Zhuang wrote:
> +static void __init hi3xxx_init(void)
> +{
> +	l2x0_of_init(0, ~0UL);

	l2x0_of_init(0, ~0);

please, no need for a UL suffix on it.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
