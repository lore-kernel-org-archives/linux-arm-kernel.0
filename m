From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2012 18:00:00 +0530
Subject: [PATCH v3 6/6] ARM: davinci: remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <1352853207-20602-6-git-send-email-rtivy@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-6-git-send-email-rtivy@ti.com>
Message-ID: <50AB77C8.5090309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/14/2012 6:03 AM, Robert Tivy wrote:
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> 
> ---
>  drivers/remoteproc/Kconfig              |   41 +++++
>  drivers/remoteproc/Makefile             |    1 +
>  drivers/remoteproc/davinci_remoteproc.c |  292 +++++++++++++++++++++++++++++++

scripts/get_maintainer.pl tells me that Ohad Ben-Cohen needs to take
this driver or at least say he is happy with it. Please CC him and LKML
on your next post.

Thanks,
Sekhar
