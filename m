From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Nov 2009 10:33:14 +0900
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
Message-ID: <000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, everyone

On Tue, Nov 10, 2009 at 9:20PM +0900, Ben Dooks wrote:

> We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
> more generic plat-samsung with less code in the other plat- directories
> to make it easier to port new devices and try and clear up some of the
> naming issues with newer devices.
> 
> Start by creating a small arch/arm/plat-samsung with no actuall code in
> so we can move items in as we process them.
(snip)

Ok, good.

We will be creating plat-s5p following to plat-samsung and will be submitted
soon.

Thanks.
Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
