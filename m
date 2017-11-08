From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:33:40 -0800
Subject: [PATCH v2 08/12] hwrng: bcm2835-rng: Abstract I/O accessors
In-Reply-To: <20171108004449.32730-9-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-9-f.fainelli@gmail.com>
Message-ID: <87efp8y60r.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> In preparation for allowing BCM63xx to use this driver, we abstract I/O
> accessors such that we can easily change those later on.

This may even be a fix on rpi, since i/o from different devices can get
reordered and you're using the barrier variants now!

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/3758dd09/attachment.sig>
