From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Apr 2011 07:01:30 -0700
Subject: [PATCH] arm: omap2plus: GPIO cleanup mach-omap2/*
In-Reply-To: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
References: <1303895153-451-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20110427140129.GH3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110427 02:02]:
> use gpio_request_<one|array>() instead of multiple gpiolib calls,
> remove unneeded variables, etc.

Great :)

Tony
