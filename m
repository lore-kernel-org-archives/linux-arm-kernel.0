From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Jun 2014 10:26:28 +0200
Subject: [PATCH] Marvell releases a public Armada 370 datasheet
In-Reply-To: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402413878-20224-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140611102628.7e06c8f0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 10 Jun 2014 17:24:37 +0200, Thomas Petazzoni wrote:

> Marvell has very recently (last week) released a public version of the
> datasheet for the Marvell Armada 370 SoC. This is a very good news for
> all the developers and contributors interested by the Armada 370.
> 
> The following patch adds the reference to this specification in the
> appropriate kernel documentation, where we already reference the
> publicly available documentation for other Marvell SoCs.
> 
> The documentation for the Armada XP (another, more powerful SoC,
> released approximately at the same time as the Armada 370) is not yet
> publicly available, but hopefully it should also be released in the
> near future as well.

One thing I forgot to mention and that Ezequiel Garcia reminded me is
that the Armada XP actually shares a lot of peripherals with the Armada
370. So the Armada 370 datasheet can also be very useful for people
working on Armada XP, since the vast majority of the peripherals are
essentially the same.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
