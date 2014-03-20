From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Mar 2014 17:31:55 +0000
Subject: [PATCH 1/1] regulator: Add new driver for ST's PWM controlled
 voltage regulators
In-Reply-To: <1395324654-8235-1-git-send-email-lee.jones@linaro.org>
References: <1395324654-8235-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140320173155.GG11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 02:10:54PM +0000, Lee Jones wrote:

> +	dev_info(&pdev->dev, "ST PWM Regulator registered\n");

Remove this, it's not adding anything really (the core is pretty chatty
already).  Otherwise this all seems fine modulo the issues Josh
mentioned.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/adbe3db3/attachment.sig>
