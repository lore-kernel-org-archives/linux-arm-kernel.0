From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 13:00:53 +0000
Subject: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
In-Reply-To: <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20141127130053.GW7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:43:54AM +0000, Lee Jones wrote:

> +Required properties:
> +- compatible	: "st,comms-ssc-spi" or "st,comms-ssc4-spi"

What do the two different compatible strings mean (for example, should
ssc4 be used for version 4 and higher or is it just a quirk for that
version)?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/b47715e3/attachment-0001.sig>
