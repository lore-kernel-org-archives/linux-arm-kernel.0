From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 28 Mar 2012 17:08:56 -0600
Subject: [PATCH V3 5/5] mtd: Move fdt partition documentation to a
 seperate file
In-Reply-To: <201203280817.12652.arnd@arndb.de>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-6-git-send-email-jm@lentin.co.uk>
 <201203280817.12652.arnd@arndb.de>
Message-ID: <20120328230856.ECB9F3E1151@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Mar 2012 08:17:12 +0000, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 27 March 2012, Jamie Lentin wrote:
> > 
> > Partitions are described in the same way for all mtd devices when using
> > devicetree, move the documentation to a separate file and add references
> > to it.
> > 
> > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Merged, thanks (dropping the orion-nand.txt hunk) because I'm not
applying the rest of the series!)

g.
