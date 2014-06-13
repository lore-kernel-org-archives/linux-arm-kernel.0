From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 16:23:16 -0400
Subject: [GIT PULL] ARM: mvebu: DT fix for v3.16-rc1
In-Reply-To: <20140525173637.GM8664@titan.lakedaemon.net>
References: <20140525173637.GM8664@titan.lakedaemon.net>
Message-ID: <20140613202316.GT8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Looks like this might have been lost in the shuffle?

On Sun, May 25, 2014 at 01:36:37PM -0400, Jason Cooper wrote:
> Guys,
> 
> This is a small fix for some new code going in to v3.16.  Apparently,
> there's a mis-match between what the bootloader assumes wrt NAND ECC
> settings and what the ONFI spec says.  To prevent woe and discontent, we
> need to explicitly state the ECC settings in the dts files.
> 
> At the time of this writing, this hasn't been in -next yet.  I imagine
> it'll be a few days before you pull this, so I wanted you to be aware
> asap.  These changes are set to be in -next from tonight onwards.
> 
> As usual, this is an incremental pull request from tags/mvebu-dt-3.16-2
> up to tags/mvebu-dt-3.16-3 in the mvebu/dt branch.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 599a136e5f4a7c3ca324fb2749ca235cd90c9d51:
> 
>   ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file (2014-05-16 17:57:27 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.16-3
> 
> for you to fetch changes up to 54aab8845c46b0f87947107cdc67c8ed7062a5bb:
> 
>   ARM: dts: Specify the NAND ECC scheme explicitly on Armada 385 DB board (2014-05-25 17:14:37 +0000)
> 
> ----------------------------------------------------------------
> mvebu DT changes for v3.16 (incremental #3)
> 
>  - Armada 375/38x NAND ECC fix for v3.16-rc1
> 
> ----------------------------------------------------------------
> Ezequiel Garcia (2):
>       ARM: dts: Specify the NAND ECC scheme explicitly on Armada 375 DB board
>       ARM: dts: Specify the NAND ECC scheme explicitly on Armada 385 DB board
> 
>  arch/arm/boot/dts/armada-375-db.dts | 2 ++
>  arch/arm/boot/dts/armada-385-db.dts | 2 ++
>  2 files changed, 4 insertions(+)

thx,

Jason.
