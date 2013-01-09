From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 09 Jan 2013 09:37:01 +0100
Subject: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
In-Reply-To: <1356645288-10110-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1356645288-10110-1-git-send-email-maxime.ripard@free-electrons.com>
 <1356645288-10110-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50ED2C2D.7030608@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 27/12/2012 22:54, Maxime Ripard wrote:
> The bindings assumed that the gpios properties were always there, which
> made the NO_TX and NO_RX mode not usable from device tree. Add extra
> checks to make sure that the driver can work if either MOSI or MISO is
> not used.

Can you give me your Acked-by on this, or do you have any comments on this?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
