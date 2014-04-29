From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Apr 2014 15:21:31 -0700
Subject: [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
In-Reply-To: <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
Message-ID: <20140429222131.GO15125@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:57:49PM +0100, Pawel Moll wrote:

> Components of the Versatile Express platform (configuration
> microcontrollers on motherboard and daughterboards in particular)
> talk to each other over a custom configuration bus. They
> provide miscellaneous functions (from clock generator control
> to energy sensors) which are represented as platform devices

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/1e0b3e9e/attachment.sig>
