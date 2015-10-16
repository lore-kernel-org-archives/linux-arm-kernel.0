From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 21:39:07 +0200
Subject: [PATCH v2 2/4] mtd: nand: Allow MTD_NAND_BRCMNAND to be selected
 for ARM64
In-Reply-To: <56214FC3.2060002@gmail.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
 <7901695.AWo8cP6Hz1@wuerfel> <56214FC3.2060002@gmail.com>
Message-ID: <5338147.WN3k6RsNEN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 October 2015 12:28:03 Florian Fainelli wrote:
> > 
> > Sorry, can't reproduce it any more. My patch is dated June 4, so it was
> > probably broken then but got fixed since. I normally try to verify that
> > the patches are still needed before I send them, but this time I only
> > saw the current discussion and remembered something vague about it
> > and sent what I had in my backlog of the randconfig-fixes series.
> 
> It may have been a problem before this patch:
> 
> d80d942bcc8e1555a76774d20be9800cfef2d415 ("ARM: BCM: Do not select
> CONFIG_MTD_NAND_BRCMNAND")
> -- 
> 

Yes, that must have been it. So my patch was not only outdated but
also wrong ;-)

	Arnd
