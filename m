From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:04:32 +0100
Subject: [PATCH v4 07/11] pwm: pwm-tiehrpwm: pinctrl support
In-Reply-To: <1353503469-18634-8-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-8-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122210432.GE16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:04PM +0530, Philip, Avinash wrote:
[...]
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");

Same comment as for patch 5.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/5357d83c/attachment.sig>
