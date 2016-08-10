From: groeck@google.com (Guenter Roeck)
Date: Wed, 10 Aug 2016 15:19:41 -0700
Subject: [v10 PATCH 2/5] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1470785557-21974-3-git-send-email-zyw@rock-chips.com>
References: <1470785557-21974-1-git-send-email-zyw@rock-chips.com>
 <1470785557-21974-3-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTd_HVqQ2Hx5_TFpM3xhnMXz3JpaXG8QHkv6wAzUCtYp8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2016 at 4:32 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates. Hence, create 2 PHY deivces, the phy[0] for DP,
> and phy[1] for USB3.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Tested-by: Guenter Roeck <groeck@chromium.org>
