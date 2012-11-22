From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Nov 2012 14:25:51 +0100
Subject: [PATCH 0/2] clk: ux500: Add abx500 clock driver
In-Reply-To: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
References: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZnrCdp=c+Ln2mNaxpnwg5HRgdcDz4U2wX=ToTG8sUYJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:35 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The abx500 clocks will not be initialized from the normal clk init call.
>
> Instead the abx500 clocks relies on the abx500-core and therfore it also
> make sense to let it be a child device to it.
>
> Right now, I am not sure of which tree to go through when merging this, but
> until that is settled I hope to collect ACKs.
>
> Upcoming series will add the abx500 clock implementations and definitions.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for all.

I think the best is to have Sam ACK it and take this through
Mr. Turquette's tree?

Yours,
Linus Walleij
