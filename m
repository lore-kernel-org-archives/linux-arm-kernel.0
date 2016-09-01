From: dianders@chromium.org (Doug Anderson)
Date: Thu, 1 Sep 2016 14:57:58 -0700
Subject: [PATCH v4 4/6] arm64: dts: rockchip: add the gmac power domain on
 rk3399
In-Reply-To: <1472752204-8924-5-git-send-email-wxt@rock-chips.com>
References: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
 <1472752204-8924-5-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=Ww2eGyCbKAxFWNaMEzwwHEZJKvyeYpSGaX_2YqcLUM_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 10:50 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> This patch supports the gmac pd to save power consumption.
> Even though some boards not need Ethernet support, the driver
> core can also take care of powering up the pd before probe.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
> Changes in v4:
> - remove the Roger signed-off for domain patch.
>
> Changes in v3:
> - leave into two patches based on patchv2, and fix nits and commit, as
>   comment on https://patchwork.kernel.org/patch/9306339/
>
> Changes in v2:
> - Fixes the order, ss Heiko commnets on
>   https://patchwork.kernel.org/patch/9305991/
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
