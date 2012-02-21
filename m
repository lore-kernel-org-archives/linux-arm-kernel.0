From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Feb 2012 20:14:46 +0900
Subject: [PATCH 09/12] ARM: S3C2416: move mach-s3c2416/* into mach-s3c24xx/
In-Reply-To: <201202211142.59542.heiko@sntech.de>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
 <1329346545-16373-10-git-send-email-kgene.kim@samsung.com>
 <201202211142.59542.heiko@sntech.de>
Message-ID: <00b301ccf08a$04fcef20$0ef6cd60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Hi Kgene,
> 
Hi,

> Am Mittwoch, 15. Februar 2012, 23:55:43 schrieb Kukjin Kim:
> > This patch moves S3C2416 stuff into mach-s3c24xx/ directory
> > so that we can merge the s3c24 series' directories to the
> > just one mach-s3c24xx/ directory.
> >
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> the patch is missing something like the following to prevent an error
> because
> "built-in.o" in mach-s3c2416 cannot be found:
> 
Yes, you're right and it is due to dummy file in mach-s3c2416/.

I think, it can be solved after done of moving remained files to regarding
directory such as drivers/cpufreq/.

As a note, you can see it before this weekend :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
