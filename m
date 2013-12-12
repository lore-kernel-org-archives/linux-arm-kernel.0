From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 16:52:40 +0000
Subject: [PATCH 2/3] regulator: act8865: add device tree binding doc
In-Reply-To: <1386811131-2720-3-git-send-email-wenyou.yang@atmel.com>
References: <1386811131-2720-1-git-send-email-wenyou.yang@atmel.com>
 <1386811131-2720-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131212165240.GP11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:18:50AM +0800, Wenyou Yang wrote:

> +Required properties:
> +- compatible: "active-semi,act8865"
> +- reg: I2C slave address
> +- vsel-state-low: Initial state of vsel0 input is low, to select default output voltage.

This needs to document which regulators exist and what strings should be
used to select them as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/6595b695/attachment.sig>
