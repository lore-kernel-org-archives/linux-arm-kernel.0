From: groeck@google.com (Guenter Roeck)
Date: Thu, 21 Jul 2016 18:40:50 -0700
Subject: [v6 PATCH 6/6] drm/rockchip: cdn-dp: add cdn DP support for rk3399
In-Reply-To: <1469106808-28297-7-git-send-email-zyw@rock-chips.com>
References: <1469106808-28297-1-git-send-email-zyw@rock-chips.com>
 <1469106808-28297-7-git-send-email-zyw@rock-chips.com>
Message-ID: <CABXOdTcOSbu8aU67MYEKgZ25tV8MmOq1HAfZYnR+6CwT7v6S4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 6:13 AM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add support for cdn DP controller which is embedded in the rk3399
> SoCs. The DP is compliant with DisplayPort Specification,
> Version 1.3, This IP is compatible with the rockchip type-c PHY IP.
> There is a uCPU in DP controller, it need a firmware to work,
> please put the firmware file to /lib/firmware/cdn/dptx.bin. The

/lib/firmware/rockchip/dptx.bin
