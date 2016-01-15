From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jan 2016 17:59:05 +0000
Subject: [PATCH 2/2] regulator: add documentation for ACT8945A's
 regulator DT bindings
In-Reply-To: <1452218938-10621-3-git-send-email-wenyou.yang@atmel.com>
References: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
 <1452218938-10621-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160115175905.GB6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:08:58AM +0800, Wenyou Yang wrote:

> +Optional properties:
> +- active-semi,vsel-high: Indicates if the VSEL pin is set to logic-high.
> +  If this property is missing, assume the VSEL pin is set to logic-low.

Wouldn't such a pin normally be connected to a GPIO for runtime control
- why is it expected to be tied statically all the time?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/6bbc6a8f/attachment.sig>
