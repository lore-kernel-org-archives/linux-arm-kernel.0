From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:36:53 -0800
Subject: [PATCH v2 12/12] hwrng: bcm63xx-rng: Remove since bcm2835-rng
 takes over
In-Reply-To: <20171108004449.32730-13-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-13-f.fainelli@gmail.com>
Message-ID: <87bmkcy5ve.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> bcm2835-rng is now capable of supporting the BCM63xx hardware, so remove
> the driver which duplicates the same functionality.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Assuming Stefan's testing says that the .name handling you settled on
works, patches 9, 11, 12 are:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/7dc44af9/attachment.sig>
