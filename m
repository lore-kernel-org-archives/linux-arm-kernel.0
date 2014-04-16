From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Apr 2014 22:31:41 +0100
Subject: [PATCH 2/4] mfd: bcm590xx: add support for second i2c slave
 address space
In-Reply-To: <20140416110603.GA19671@lee--X1>
References: <1397501428-8857-1-git-send-email-mporter@linaro.org>
 <1397501428-8857-3-git-send-email-mporter@linaro.org>
 <20140416110603.GA19671@lee--X1>
Message-ID: <20140416213141.GD12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:06:03PM +0100, Lee Jones wrote:

> s/regmap/Regmap

It's consistently written regmap in all the documentation and so on :)

> addmap{0,1} doesn't quite sit right with me.

> REVISIT: Ah, it's address-map, rather than add map. Okay, not as bad
> as I first thought, but still, is there a better naming convention you
> could use?

addrmap or something?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/eb361ccd/attachment-0001.sig>
