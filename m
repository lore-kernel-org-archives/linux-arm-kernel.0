From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 9 Aug 2012 14:36:51 +0800
Subject: [PATCH] ARM: mmp: add USB3.0 PHY support
In-Reply-To: <1344483203-17446-1-git-send-email-yuxu@marvell.com>
References: <1344483203-17446-1-git-send-email-yuxu@marvell.com>
Message-ID: <CAN1soZzWur7idY9jEwKTETo0NeZfSkycso44GtWKuftX1HT+9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 11:33 AM, Yu Xu <yuxu@marvell.com> wrote:
> Add USB 3.0 PHY support.
>
> Signed-off-by: Yu Xu <yuxu@marvell.com>
> ---
>  arch/arm/mach-mmp/devices.c               |  227 +++++++++++++++++++++++++++++
>  arch/arm/mach-mmp/include/mach/regs-usb.h |   94 ++++++++++++
>  2 files changed, 321 insertions(+)
>

I hope that you can move USB PHY init into usb drivers. Since your
current implementation
would be add callback in platform data. It should be avoid since it's
a block of device tree
implementation.

Regards
Haojian
