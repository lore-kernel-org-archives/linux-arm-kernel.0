From: ben@trinity.fluff.org (Ben Dooks)
Date: Sun, 21 Feb 2010 23:12:30 +0000
Subject: [PATCH 3/4] s3c24xx_adc: disable/enable IRQ on suspend/resume
In-Reply-To: <1266510750-9846-4-git-send-email-anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<1266510750-9846-4-git-send-email-anarsoul@gmail.com>
Message-ID: <20100221231230.GC30679@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 06:32:29PM +0200, Vasily Khoruzhick wrote:
> IRQ should be disabled on suspend and re-enabled on resume.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Ok, added to next-s3c24xx-ts

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
