From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2011 15:00:52 +0000
Subject: [AT91 PULL v2] defconfig pull request
In-Reply-To: <20111124140658.GH15531@game.jcrosoft.org>
References: <20111102155803.GE7136@game.jcrosoft.org>
 <201111232115.08556.arnd@arndb.de> <20111124140658.GH15531@game.jcrosoft.org>
Message-ID: <201111241500.52871.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	this a split of the previous pull request that containt onlythe
> 	defconfig
> 
> 	the gpio part will for 3.2
> 
> 	this pull request will introduce a defconfig per soc with all machine
> 	enabled (today we can not compile multiple soc together we work on it)
> 
> 	This will allow us to check that we break no board
> 
> 	v2:
> 	update patch as sugested by Arnd

Ok, pulled into 'fixes' now. I ended up rebasing to v3.2-rc2 to have a
clean base instead of a random point between rc2 and rc3.

	Arnd
