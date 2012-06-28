From: davem@davemloft.net (David Miller)
Date: Wed, 27 Jun 2012 21:30:53 -0700 (PDT)
Subject: [PATCH v2 0/5] fec driver updates
In-Reply-To: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
References: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120627.213053.2138662759941342784.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Wed, 27 Jun 2012 21:45:19 +0800

> Changes since v1:
> * Add one patch to use devm_gpio_request_one
> * Have a separate patch to fix phy-reset-gpios property in binding
>   document
> * Change phy-reset-interval to phy-reset-duration
> * Add a sanity check on phy-reset-duration value

All applied.
