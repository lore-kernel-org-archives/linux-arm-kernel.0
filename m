From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 10:19:46 +0200
Subject: [PATCH 06/11 v5] coresight-replicator: add CoreSight Replicator
 driver
In-Reply-To: <1409159852-7249-7-git-send-email-mathieu.poirier@linaro.org>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-7-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdb2PvkUOyVkhzk8WF457kZ5zqQVo5eFSMHk8u+mbNaZXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:

> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver manages non-configurable CoreSight Replicator that
> takes a single input trace data stream and replicates it to
> produce two identical trace data output streams. Replicators
> are typically used to route single interleaved trace data
> stream to two or more sinks.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
