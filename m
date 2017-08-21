From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 07:50:48 +0200
Subject: [PATCH v2 1/2] dt-bindings: pwm: add bindings doc for ZTE ZX PWM
 controller
In-Reply-To: <1501143817-15843-2-git-send-email-shawnguo@kernel.org>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
 <1501143817-15843-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170821055048.GB18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 04:23:36PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It adds bindings document for ZTE ZX PWM controller.  The device
> has two clocks: PCLK and WCLK.  The PCLK is for register access, and
> WCLK is the reference clock for calculating period and duty cycles.
> Also, the device supports polarity configuration, so #pwm-cells should
> be 3.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-zx.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt

Applied to for-4.14/drivers, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/5095ab28/attachment.sig>
