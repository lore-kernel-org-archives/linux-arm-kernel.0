From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 17:17:10 -0500
Subject: [PATCHv2 0/4] ARM: mvebu/kirkwood: NETGEAR ReadyNAS .dts files
 cleanup
In-Reply-To: <cover.1385756371.git.arno@natisbad.org>
References: <cover.1385756371.git.arno@natisbad.org>
Message-ID: <20131201221710.GB2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 09:27:13PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> This series provides some cleanup for all NETGEAR ReadyNAS .dts files
> (Duo v2, 102 and 104). This is mostly based on suggestions from
> Sebastian during RN2120 .dts submission. Jason, two remarks:
> 
>  - Patch 1/4 applies on top of previous gpio-poweroff patch for Duo v2
>  - Patch 3/4 applies on NXP PCA 9554 patch for RN104
> 
> As requested, last patch (4/4) contains whitespace cleanups for those
> .dts (in fact, mainly Duo v2 and a single hunk for RN102).
> 
> This v2 mainly removes PHY compatible strings for simple comments.
> 
> Comments welcome,
> 
> Cheers,
> 
> a+
> 
> Arnaud Ebalard (4):
>   ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts cleanup
>   ARM: mvebu: NETGEAR ReadyNAS 102 .dts cleanup
>   ARM: mvebu: NETGEAR ReadyNAS 104 .dts cleanup
>   ARM: Fix whitespaces in NETGEAR ReadyNAS .dts files
> 
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 82 ++++++++++--------
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 68 +++++++--------
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 99 +++++++++++++---------
>  3 files changed, 141 insertions(+), 108 deletions(-)

whole series applied to mvebu/dt.  There was a small conflict with
Sebastian's pinctrl work.  Please double check and let me know if
anything is amiss.

thx,

Jason.
