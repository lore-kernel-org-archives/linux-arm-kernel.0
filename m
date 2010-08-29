From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 29 Aug 2010 14:01:03 +0300
Subject: [PATCH] nand: fix .correct callback return value check
In-Reply-To: <ca767a0d6cafbea862c307e944c2b800dafb6660.1281327492.git.baruch@tkos.co.il>
References: <20100808204341.GA20065@pengutronix.de>
	<ca767a0d6cafbea862c307e944c2b800dafb6660.1281327492.git.baruch@tkos.co.il>
Message-ID: <1283079663.2131.0.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-08-09 at 07:20 +0300, Baruch Siach wrote:
> Drivers may (and do) return negative errno values other than -1 from the
> .correct callback.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Pushed to l2-mtd-2.6.git / master, thank you!

Artem.
