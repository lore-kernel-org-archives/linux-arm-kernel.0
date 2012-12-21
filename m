From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 12:22:34 -0700
Subject: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
In-Reply-To: <87a9t78boa.fsf@dell.be.48ers.dk>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <87a9t78boa.fsf@dell.be.48ers.dk>
Message-ID: <20121221192234.GA10722@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 08:09:25PM +0100, Peter Korsgaard wrote:
> >>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:
> 
>  Mark> From: "Mark A. Greer" <mgreer@animalcreek.com>
>  Mark> [This series supersedes the hwmod related patches sent in the
>  Mark>  "crypto: omap-sham updates" and "crypto: omap-aes updates"
>  Mark>  series a few weeks ago.]
> 
>  Mark> This series adds hwmod support for the OMAP SHAM and AES
>  Mark> modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
>  Mark> adds device tree info for those modules.
> 
> Huh, does am335x have a sham module? I don't see any mention of that in
> spruh73g.pdf

Yes.  It has sham, aes, and rng modules.

They are not described in the TRM.  In fact, I had to use the omap4
description (closely guarded by TI) because AFAIK there isn't a doc
for the am33xx.  The am33xx modules are identical to the omap4 ones
except for the register addresses and dma channels so that doc worked.

Mark
--
