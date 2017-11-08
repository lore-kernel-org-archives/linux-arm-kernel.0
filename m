From: eric@anholt.net (Eric Anholt)
Date: Wed, 08 Nov 2017 10:24:11 -0800
Subject: [PATCH v2 05/12] hwrng: bcm2835-rng: Use device managed helpers
In-Reply-To: <20171108004449.32730-6-f.fainelli@gmail.com>
References: <20171108004449.32730-1-f.fainelli@gmail.com>
 <20171108004449.32730-6-f.fainelli@gmail.com>
Message-ID: <87mv3wy6gk.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Now that we have moved the RNG disabling into a hwrng::cleanup callback,
> we can use the device managed registration operation and remove our
> remove callback since it won't do anything necessary.

3-5 are:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/e54637c2/attachment.sig>
