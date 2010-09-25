From: ben@simtec.co.uk (Ben Dooks)
Date: Sun, 26 Sep 2010 00:22:59 +0100
Subject: [PATCH 2/5] h1940: fix h1940-bluetooth compilation
In-Reply-To: <1283871605-32068-3-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-1-git-send-email-anarsoul@gmail.com>
	<1283871605-32068-3-git-send-email-anarsoul@gmail.com>
Message-ID: <4C9E8453.2020306@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 16:00, Vasily Khoruzhick wrote:
> h1940-bluetooth.c doesn't compile after s3c gpio API changes,
> this patch fixes issue.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2410/h1940-bluetooth.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

thanks, applied to for-linus/2636/s3c24xx-fixes.

-- 
Ben
