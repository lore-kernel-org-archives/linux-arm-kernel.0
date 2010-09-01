From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 02 Sep 2010 02:20:14 +0300
Subject: [PATCH] ARM: pxa3xx: fix build error when
	CONFIG_MTD_PARTITIONS is not defined
In-Reply-To: <1282813011-6187-2-git-send-email-mark.brown314@gmail.com>
References: <1282813011-6187-1-git-send-email-mark.brown314@gmail.com>
	<1282813011-6187-2-git-send-email-mark.brown314@gmail.com>
Message-ID: <1283383214.2209.63.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-26 at 04:56 -0400, Mark F. Brown wrote:
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Pushed to l2-mtd-2.6 / for-2.6.36, thanks.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
