From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Oct 2015 17:58:43 +0200
Subject: [PATCH v7 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
In-Reply-To: <1439882875-19596-2-git-send-email-yh.huang@mediatek.com>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
 <1439882875-19596-2-git-send-email-yh.huang@mediatek.com>
Message-ID: <20151005155843.GD17612@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 03:27:53PM +0800, YH Huang wrote:
> Document the device-tree binding of MediaTek display PWM.
> The PWM has one channel to control the backlight brightness for display.
> It supports MT8173 and MT6595.
> 
> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   42 ++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/f1afe9ac/attachment.sig>
