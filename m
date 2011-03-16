From: premi@ti.com (Premi, Sanjeev)
Date: Wed, 16 Mar 2011 13:58:13 +0530
Subject: [PATCHv2] omap3: alsa-soc: Remove restrictive checks for cpu type
In-Reply-To: <1300116162-25488-1-git-send-email-premi@ti.com>
References: <1300116162-25488-1-git-send-email-premi@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C30799E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, March 14, 2011 8:53 PM
> To: linux-omap at vger.kernel.org; alsa-devel at alsa-project.org; 
> linux-arm-kernel at lists.infradead.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv2] omap3: alsa-soc: Remove restrictive checks 
> for cpu type
> 
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Changes in this version:
>  1) Added one more check to the changes.
>  2) Updated commit message to use plurals.
> 
>  sound/soc/omap/omap-mcbsp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

[sp] This patch didn't seem to be lost in transit!
     Sending it again.

     Did anyone else ever face this issue?

~sanjeev
