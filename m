From: jhnikula@gmail.com (Jarkko Nikula)
Date: Wed, 13 Apr 2011 09:15:48 +0300
Subject: [PATCHv3] omap3: alsa-soc: Remove restrictive checks for cpu type
In-Reply-To: <1302640393-21734-1-git-send-email-premi@ti.com>
References: <1302640393-21734-1-git-send-email-premi@ti.com>
Message-ID: <20110413091548.bfb3ddd9.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Apr 2011 02:03:13 +0530
Sanjeev Premi <premi@ti.com> wrote:

> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Changes in v3::
>    None. Reposting[1] after subscribing to alsa-devel list
> 
>  Changes in v2:
>    1) Added one more check to the changes.
>    2) Updated commit message to use plurals.
> 
> 
>  [1] http://marc.info/?l=linux-omap&m=130026430110592&w=2
> 
>  sound/soc/omap/omap-mcbsp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
