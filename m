From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jan 2016 01:16:03 +0100
Subject: [PATCH v4 1/2] regulator: act8945a: add regulator driver for
 ACT8945A
In-Reply-To: <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
References: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
 <1453863463-30515-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160129001603.GM4130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 10:57:42AM +0800, Wenyou Yang wrote:

> +static const struct of_device_id act8945a_pmic_of_match[] = {
> +	{ .compatible = "active-semi,act8945a-regulator" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, act8945a_pmic_of_match);

This seems mostly OK but why do we have a compatible string here -
shouldn't the MFD be able to instantiate the regulator function without
needing this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/cd5f0e17/attachment.sig>
