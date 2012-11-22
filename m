From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 21:57:33 +0100
Subject: [PATCH v4 04/11] pwm: pwm-tiecap: Add device-tree binding
 support for APWM driver
In-Reply-To: <1353503469-18634-5-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-5-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122205732.GB16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:01PM +0530, Philip, Avinash wrote:
[...]
> +static const struct of_device_id ecap_of_match[] = {
> +	{
> +		.compatible	= "ti,am33xx-ecap",
> +	},

Same here, can be shorter by putting it on one line instead of three.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/aa26e773/attachment.sig>
