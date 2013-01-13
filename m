From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 13 Jan 2013 09:57:56 +0100
Subject: [PATCH 1/7] clk: add common of_clk_init() function
In-Reply-To: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50F27714.3060906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prashant,

On 04/01/2013 08:00, Prashant Gaikwad wrote:
> Modify of_clk_init function so that it will determine which
> driver to initialize based on device tree instead of each driver
> registering to it.
> 
> Based on a similar patch for drivers/irqchip by Thomas Petazzoni and
> drivers/clocksource by Stephen Warren.

I finally had some time to test your changes on sunxi, and you can add
for patches 1 and 3:
Acked-by: Maxime Ripard <maxime.ripard@anandra.org>

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
