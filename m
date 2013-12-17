From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 12:47:50 +0000
Subject: [PATCH 2/3 v2] regulator: act8865: add device tree binding doc
In-Reply-To: <1387258597-21866-3-git-send-email-wenyou.yang@atmel.com>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131217124750.GX3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:36:36PM +0800, Wenyou Yang wrote:

> +Required properties:
> +- compatible: "active-semi,act8865"
> +- reg: I2C slave address

This needs to also document the regulators property, for example all the
regulator names.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/c58077d7/attachment.sig>
