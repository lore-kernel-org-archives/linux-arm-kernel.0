From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Oct 2016 12:52:44 +0200
Subject: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
In-Reply-To: <1477637418-38938-4-git-send-email-yangbo.lu@nxp.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-4-git-send-email-yangbo.lu@nxp.com>
Message-ID: <2723366.1bJeJ7SKI6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 28, 2016 2:50:14 PM CEST Yangbo Lu wrote:
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> header file.  This SVR numberspace is used on some ARM chips as well as
> PPC, and even to check for a PPC SVR multi-arch drivers would otherwise
> need to ifdef the header inclusion and all references to the SVR symbols.
> 
> 

I don't see any of the contents of this header referenced by the soc driver
any more. I think you can just drop this patch.

	Arnd
