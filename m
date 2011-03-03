From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Mar 2011 17:00:03 -0800
Subject: [PATCH] ldp: Fix regulator mapping for ads7846 TS controller
In-Reply-To: <1298552202-28307-1-git-send-email-rnayak@ti.com>
References: <1298552202-28307-1-git-send-email-rnayak@ti.com>
Message-ID: <20110303010002.GF20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [110224 04:54]:
> On the OMAP3430LDP board, the ads7846 touchscreen controller
> is powered by VAUX1 regulator (supplying 3.0v).
> Fix this mapping in the board file, and hence prevent
> the ads7846 driver init to fail with the below error..
> 
> ads7846 spi1.0: unable to get regulator: -19

Applying for the merge window.

Tony
