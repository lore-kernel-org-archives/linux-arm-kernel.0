From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:15:55 +0530
Subject: [PATCH 04/17] i2c: omap: simplify omap_i2c_ack_stat()
In-Reply-To: <1339669250-9183-5-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-5-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gydS0qFCq705pHj6jZbyqLEMmtdw1dNYAezBowpxbk9Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> stat & BIT(1) is the same as BIT(1), so let's
> simplify things a bit by removing "stat &" from
> all omap_i2c_ack_stat() calls.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Indeed. Looks good to me.
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
