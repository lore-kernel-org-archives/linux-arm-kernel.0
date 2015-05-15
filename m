From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:41:55 +0200
Subject: [GIT PULL] pxa for v4.2
In-Reply-To: <87a8x8kvf2.fsf@belgarion.home>
References: <87a8x8kvf2.fsf@belgarion.home>
Message-ID: <2255900.y1e846AToc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 23:41:05 Robert Jarzmik wrote:
> ----------------------------------------------------------------
> This is the pxa changes for v4.2 cycle.
> 
> The main and only feature is the conversion of all pxa variants to clock
> framework. This encompasses pxa25x, pxa27x and pxa3xx, for all boards.
> 
> This should be a disruptive cycle in the normally quiet pxa history, as
> the change can break any platform, and the test were performed on only 4
> boards (lubbock, zylonite, mioa701, cm-x300).
> 

Pulled into next/soc, thanks!

	Arnd
