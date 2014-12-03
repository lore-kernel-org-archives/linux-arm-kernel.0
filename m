From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:53:31 +0100
Subject: [PATCH 09/12] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <1417565531-4507-10-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-10-git-send-email-stefan@agner.ch>
Message-ID: <2260991.G6QM1xu48B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:08 Stefan Agner wrote:
> Remove the needless differences between MMU/!MMU addruart calls.
> This allows to use the same addruart macro on SoC level. Useful
> for SoC consisting of multiple CPUs with and without MMU such as
> Freescale Vybrid.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 

I think I had the same patch somewhere hidden in my collection
of stuff I need to submit one day. Looks good.

	Arnd
