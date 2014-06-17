From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Jun 2014 23:45:32 +0200
Subject: [PATCH 2/3] pwm: rockchip: document device tree bindings
In-Reply-To: <1399504115-16257-3-git-send-email-b.galvani@gmail.com>
References: <1399504115-16257-1-git-send-email-b.galvani@gmail.com>
 <1399504115-16257-3-git-send-email-b.galvani@gmail.com>
Message-ID: <20140617214529.GB24743@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 01:08:34AM +0200, Beniamino Galvani wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> new file mode 100644
> index 0000000..35deba4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
> @@ -0,0 +1,17 @@
> +Rockchip PWM controller
> +
> +Required properties:
> + - compatible: should be "rockchip,rk2928-pwm"
> + - reg: physical base address and length of the controller's registers
> + - clocks: phandle and clock specifier of the PWM reference clock
> + - #pwm-cells: should be 2. See pwm.txt in this directory for a
> +   description of the cell format

Nit: this sentence should have a full stop at the end.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/0952f1bc/attachment.sig>
