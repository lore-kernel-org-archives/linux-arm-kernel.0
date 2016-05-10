From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 May 2016 16:06:59 +0200
Subject: [GIT PULL] at91: dt for 4.7 #3
In-Reply-To: <1462546579-3398-1-git-send-email-nicolas.ferre@atmel.com>
References: <1462546579-3398-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5988589.hj0Gr8KPDl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 May 2016 16:56:19 Nicolas Ferre wrote:
> Some more DT material for 4.7. The fix on the VInCo platform is due to an error
> on the Ethernet driver that was not taking the gpio flag into account. As it is
> about to be fixed now, I have to update the only DT that was making use of it.
> Otherwise, all is about the TRNG nodes addition.
> 
> 

Pulled into next/dt, thanks!

	Arnd
