From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Jan 2017 16:22:53 +0530
Subject: [PATCH v4 06/14] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <1484832588-18413-7-git-send-email-bgolaszewski@baylibre.com>
References: <1484832588-18413-1-git-send-email-bgolaszewski@baylibre.com>
 <1484832588-18413-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <fcbafcd6-4ecc-0f76-0f8c-960814c39423@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 January 2017 06:59 PM, Bartosz Golaszewski wrote:
> Register a dummy clock modelling the external SATA oscillator for

I had asked about this earlier. I dont think calling it a dummy clock is
right. Can you fix it or respond to my earlier mail with any objections?

> da850 (both DT and board file mode).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks,
Sekhar
