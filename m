From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 10:13:55 +0200
Subject: [PATCH 02/11 v5] coresight-tmc: add CoreSight TMC driver
In-Reply-To: <1409159852-7249-3-git-send-email-mathieu.poirier@linaro.org>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdZ-nTCkPRg8iDCJM2G2ic1_3RnzmE_jkdnagSM73DyCkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:

> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver manages CoreSight TMC (Trace Memory Controller) which
> can act as a link or a sink depending upon its configuration. It
> can present itself as an ETF (Embedded Trace FIFO) or ETR
> (Embedded Trace Router).
>
> ETF when configured in circular buffer mode acts as a trace
> collection sink. When configured in HW fifo mode it acts as link.
> ETR always acts as a sink and can be used to route data to memory
> allocated in RAM.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This looks good to me now.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
