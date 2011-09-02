From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 23:34:25 -0400 (EDT)
Subject: [GIT PULL] CPU mapping platform updates for 3.2
In-Reply-To: <20110901211107.GB5209@e102144-lin.cambridge.arm.com>
References: <20110901211107.GB5209@e102144-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1109012331010.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Sep 2011, Will Deacon wrote:

> Hi Arnd,
> 
> Please pull the following CPU mapping patches for 3.2. Russell has merged
> the core changes into his for-next branch, so this pull is based against
> that (following the merging discussion we had previously). I can rebase
> onto next/master if you prefer.
> 
> Cheers,
> 
> Will
> 
> 
> The following changes since commit 3ad29450aa243a318fae5d50bdc918760436bb02:
> 
>   Merge branch 'devel-stable' into for-next (2011-08-28 10:41:19 +0100)

No, please don't use that as a base.  This commit is likely to vanish 
the next time RMK reconstructs his for-next branch.  You should instead 
base those patches on the actual branch tip that RMK merged from you.


Nicolas
