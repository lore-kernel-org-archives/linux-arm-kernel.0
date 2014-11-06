From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Nov 2014 21:03:39 +0100
Subject: [RFC PATCH] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <545BD0C2.6000408@alliedtelesis.co.nz>
References: <1415249396-2985-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141106144950.GA4974@lunn.ch>
 <545BD0C2.6000408@alliedtelesis.co.nz>
Message-ID: <20141106200339.GE4974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> I'm working on a new board that uses a integrated CPU that according to the
> >> vendor is "based on the ARMADA-XP", more on that to come in the future
> >> hopefully.
> > A packet processor chip with an embedded CPU? Next generation
> > Prestera?  No need to answer that if you don't want to.

> You guess correctly. Not sure how much I can say without falling foul of 
> our NDA but they know I intend on trying to get this stuff upstream 
> rather than being locked into their particular SDK.

Hi Chris

Nice to hear you want to upstream it. There are some interesting
chips, even in consumer level devices like the TPE-1620WS, which i
would love to play with. But the Switching part of Marvell don't seem
interested in the community, unlike the processors part of Marvell
which is engaging with the community.

      Andrew
