From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 3 Oct 2012 16:08:05 +0530
Subject: [PATCH] ARM: davinci: dm644x: fix out range signal for ED
In-Reply-To: <1349246100-7477-1-git-send-email-prabhakar.lad@ti.com>
References: <1349246100-7477-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <506C158D.4000906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2012 12:05 PM, Prabhakar wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> while testing display on dm644x, for ED out-range signals
> was observed. This patch fixes appropriate clock setting
> for ED.

Can you please clarify what you mean by "out range signal"? Are there
any user visible artifacts on the display? What was the clock being
provided earlier and what is the value after this patch?

Also, is the issue severe enough that this patch should be applied to
stable tree as well?

Thanks,
Sekhar
