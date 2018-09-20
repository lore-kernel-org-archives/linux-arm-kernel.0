From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Sep 2018 14:24:59 -0700
Subject: [PATCH] ARM: OMAP1: ams-delta: Don't request unused GPIOs
In-Reply-To: <20180910195008.24127-1-jmkrzyszt@gmail.com>
References: <20180910195008.24127-1-jmkrzyszt@gmail.com>
Message-ID: <20180920212459.GU5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 12:53]:
> GPIOs with no kernel drivers can still be used from user space, don't
> request them from the board file.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks applying into omap-for-v4.20/omap1.

Regards,

Tony
