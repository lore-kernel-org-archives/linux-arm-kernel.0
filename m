From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 3 Feb 2016 11:19:52 +1100
Subject: [linux-sunxi] [PATCH 01/11] MAINTAINERS: Add entry for X-Powers
 AXP family PMIC drivers
In-Reply-To: <1454408864-24112-2-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-2-git-send-email-wens@csie.org>
Message-ID: <CAGRGNgVxan9RCsLFW9hHWcdW+Rd_SgVG95H-yQg213g-YeE6Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Feb 2, 2016 at 9:27 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Add an entry for X-Powers AXP family PMIC drivers and list myself
> as maintainer.
>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Cc: Todd Brandt <todd.e.brandt@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f678c37107f5..7ea4e54f566a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11941,6 +11941,12 @@ F:     include/linux/workqueue.h
>  F:     kernel/workqueue.c
>  F:     Documentation/workqueue.txt
>
> +X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS
> +M:     Chen-Yu Tsai <wens@csie.org>
> +L:     linux-kernel at vger.kernel.org
> +S:     Maintained
> +N:     axp[128]

Should you list the files maintained and this list also?

> +
>  X.25 NETWORK LAYER
>  M:     Andrew Hendry <andrew.hendry@gmail.com>
>  L:     linux-x25 at vger.kernel.org

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
