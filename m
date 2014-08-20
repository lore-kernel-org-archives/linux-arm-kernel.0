From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 20 Aug 2014 16:40:01 +0400
Subject: [RFC PATCH 6/6] rtc: rtc-isl12057: Change vendor prefix for
 Intersil Corporation to isil
In-Reply-To: <1408524184-31928-7-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <53F49721.1000407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 8/20/2014 12:43 PM, Philipp Zabel wrote:

> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
> Patch 70e123373c05 added this driver with device tree support

    Please also specify that commit's summary line in parens.

> using the then documented isl vendor prefix, so we keep that
> around for backwards compatibility.

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

WBR, Sergei
