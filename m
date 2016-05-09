From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:36:16 -0500
Subject: [PATCH 4/4] drivers/clocksource/moxart: Add Aspeed support
In-Reply-To: <1462797169-14512-5-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
 <1462797169-14512-5-git-send-email-joel@jms.id.au>
Message-ID: <20160509203616.GA4843@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 10:02:49PM +0930, Joel Stanley wrote:
> The Aspeed SoC has timer IP with a very similar register layout to the
> moxart timer. This patch adds support for the fourth and fifth gen
> aspeed SoCs, and has been tested on the ast2400 and ast2500.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../bindings/timer/moxa,moxart-timer.txt           |  4 ++-
>  drivers/clocksource/moxart_timer.c                 | 32 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
