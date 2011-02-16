From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Feb 2011 17:49:03 +0530
Subject: [PATCH v2 0/2] Fix/Clean regulator consumer mapping for 3430sdp
In-Reply-To: <1296737122-20765-1-git-send-email-rnayak@ti.com>
References: <1296737122-20765-1-git-send-email-rnayak@ti.com>
Message-ID: <147642dc9bed7d0af86fc618cca09edd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

> -----Original Message-----
> From: Rajendra Nayak [mailto:rnayak at ti.com]
> Sent: Thursday, February 03, 2011 6:15 PM
> To: linux-omap at vger.kernel.org
> Cc: tony at atomide.com; linux-arm-kernel at lists.infradead.org;
balbi at ti.com; Rajendra Nayak
> Subject: [PATCH v2 0/2] Fix/Clean regulator consumer mapping for 3430sdp
>
> This is a short series to fix some, and clean the
> existing regulator consumer supply mappings for
> the OMAP3430sdp board.
>
> The series is boot tested on the 3430sdp board
> and applies on 2.6.38-rc3.

Any plans to pull these 3430sdp board file cleanup/fixes?

Regards,
Rajendra

>
> Changes in v2:
> Define regulator_consumer_supply as array's
> and use ARRAY_SIZE macro to define
> num_consumer_supplies
>
> Rajendra Nayak (2):
>   omap3sdp: Fix regulator mapping for ads7846 TS controller
>   omap3sdp: clean regulator supply mapping in board file
>
>  arch/arm/mach-omap2/board-3430sdp.c |   78
+++++++++++++++++------------------
>  1 files changed, 38 insertions(+), 40 deletions(-)
