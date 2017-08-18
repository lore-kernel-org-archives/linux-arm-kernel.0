From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Aug 2017 17:46:34 +0200
Subject: [PATCH v4 3/8] dt-bindings: pwm: add description for rv1108 pwm
In-Reply-To: <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
 <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20170818154634.GI18307@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 04:37:48PM +0800, Andy Yan wrote:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v4: None
> Changes in v3:
> - make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-pwm"
>   for rv1108
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/29bf427c/attachment.sig>
