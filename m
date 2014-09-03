From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 10:18:31 +0200
Subject: [PATCH 05/11 v5] coresight-funnel: add CoreSight Funnel driver
In-Reply-To: <1409159852-7249-6-git-send-email-mathieu.poirier@linaro.org>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdZ5FOKaWuX4OUFgx641OjW9Wr=tkUwX4suiknFNbQSpBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:

> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver manages CoreSight Funnel which acts as a link.
> Funnels have multiple input ports (typically 8) each of which
> represents an input trace data stream. These multiple input trace
> data streams are interleaved into a single output stream coming
> out of the Funnel.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Panchaxari Prasannamurthy <panchaxari.prasannamurthy@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
