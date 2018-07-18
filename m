From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 18 Jul 2018 17:28:49 +0200
Subject: [PATCH v3 00/23] Add multi-channel support to Armada thermal
 driver
In-Reply-To: <20180716144206.30985-1-miquel.raynal@bootlin.com>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
Message-ID: <20180718172849.30b7cec0@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 16 Jul 2018
16:41:43 +0200:

> The only capability of the Armada thermal driver is currently just to
> read one sensor (the default one) per AP and one per CP. Actually,
> there is one sensor per core in the AP806 plus one sensor in the
> thermal IP itself. The CP110 just features one thermal sensor in its
> own thermal IP.
> 
> This series first improves the readability of this driver, then adds
> support for multi-channel thermal IPs. The bindings and the
> device-trees are updated accordingly.
> 
> Thank you,
> Miqu?l

I know I sent this series on monday but there was almost no change on
it (see below), do you think you will have the time to look at it
before it's too late for the merge window?

Thank you,
Miqu?l
