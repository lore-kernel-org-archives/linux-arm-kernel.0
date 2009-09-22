From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 22 Sep 2009 21:24:21 +0100
Subject: [PATCH] S3C24XX: Define a macro to avoid compilation error
In-Reply-To: <1253549056-25322-1-git-send-email-ramaxlo@gmail.com>
References: <1253549056-25322-1-git-send-email-ramaxlo@gmail.com>
Message-ID: <20090922202421.GB31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2009 at 12:04:16AM +0800, Ramax Lo wrote:
> Define a macro to avoid the following error during kernel build process
> for platforms other than s3c2410:
> 
> arch/arm/plat-s3c24xx/cpu.c:84: error: ???s3c2410a_init??? undeclared here (not in a function)
> 
> Signed-off-by: Ramax Lo <ramaxlo@gmail.com>

ok, applied to next-s3c24xx-fixes.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
