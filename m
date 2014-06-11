From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 11 Jun 2014 10:31:07 +0200
Subject: [PATCH] Marvell releases a public Armada 370 datasheet
In-Reply-To: <20140611102628.7e06c8f0@free-electrons.com>
References: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140611102628.7e06c8f0@free-electrons.com>
Message-ID: <20140611083107.GG24672@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> One thing I forgot to mention and that Ezequiel Garcia reminded me is
> that the Armada XP actually shares a lot of peripherals with the Armada
> 370. So the Armada 370 datasheet can also be very useful for people
> working on Armada XP, since the vast majority of the peripherals are
> essentially the same.

Hi Thomas

It is great to see that Marvell have released the document. Also the
success with getting the new SoCs into mainline so fast has been
really good. Lets hope device manufactures take the hint and use
mainline, not some hacked up branch.

As to shared peripherals between 370 and XP, could you make a quick
list of where they are different? The thermal sensor is one, if i
remember correctly, but that already has a driver. The list does not
need to be too detailed, it could be just "compatible/different" for
each peripheral. It is just enough to stop somebody bashing there head
against a brick wall because the registers are different and they
don't know it.

Thanks
	Andrew
