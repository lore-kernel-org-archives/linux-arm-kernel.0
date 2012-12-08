From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 9 Dec 2012 00:20:43 +0800
Subject: [PATCH 05/25] ASoC: pxa: remove __dev* attributes
In-Reply-To: <1354890397-28568-6-git-send-email-wfp5p@virginia.edu>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
 <1354890397-28568-6-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAN1soZyzNaEfmtKPoPOuLw-9ZPe4O7og5r803qOtzSf=RD2jEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 7, 2012 at 10:26 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
>
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  sound/soc/pxa/brownstone.c     | 6 +++---
>  sound/soc/pxa/corgi.c          | 6 +++---
>  sound/soc/pxa/e740_wm9705.c    | 6 +++---
>  sound/soc/pxa/e750_wm9705.c    | 6 +++---
>  sound/soc/pxa/e800_wm9712.c    | 6 +++---
>  sound/soc/pxa/imote2.c         | 6 +++---
>  sound/soc/pxa/mioa701_wm9713.c | 6 +++---
>  sound/soc/pxa/mmp-pcm.c        | 6 +++---
>  sound/soc/pxa/mmp-sspa.c       | 6 +++---
>  sound/soc/pxa/palm27x.c        | 4 ++--
>  sound/soc/pxa/poodle.c         | 6 +++---
>  sound/soc/pxa/pxa-ssp.c        | 6 +++---
>  sound/soc/pxa/pxa2xx-ac97.c    | 8 ++++----
>  sound/soc/pxa/pxa2xx-i2s.c     | 4 ++--
>  sound/soc/pxa/pxa2xx-pcm.c     | 6 +++---
>  sound/soc/pxa/tosa.c           | 6 +++---
>  sound/soc/pxa/ttc-dkb.c        | 6 +++---
>  17 files changed, 50 insertions(+), 50 deletions(-)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
