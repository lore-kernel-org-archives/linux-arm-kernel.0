From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:31:35 +0200
Subject: [PATCH v3 1/7] pwm: rockchip: Add APB and function both clocks
 support
In-Reply-To: <1502206715-24174-2-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206715-24174-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170818153135.GB18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 11:38:29PM +0800, David Wu wrote:
> New PWM module provides two individual clocks for APB clock
> and function clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> changes in v3:
>  - clk_get with NULL argument again if it was error, when clk_get with "pwm" argument.
>  - To get clk count, use of_count_phandle_with_args instead of of_property_count_strings.
> 
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       |  8 ++-
>  drivers/pwm/pwm-rockchip.c                         | 58 ++++++++++++++++++----
>  2 files changed, 56 insertions(+), 10 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/7c900f50/attachment.sig>
