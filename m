From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Jun 2013 01:15:54 +0400
Subject: [PATCH] ARM: fix missing flush_kernel_dcache_page() for noMMU
In-Reply-To: <1371672910-9340-1-git-send-email-gmbnomis@gmail.com>
References: <1371672910-9340-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <51C21F8A.3070704@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/20/2013 12:15 AM, Simon Baatz wrote:

> Commit 1bc3974

    Please also specify that commit's summary line in parens.

> moved the implementation of flush_kernel_dcache_page()
> into in mm/flush.c but did not implement it on noMMU ARM.

> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.2+: 1bc3974: ARM: 7755/1
> Cc: <stable@vger.kernel.org> # 3.2+
> ---

> ARM 7755/1 "handle user space mapped pages in flush_kernel_dcache_page"

    Aha, this is that summary, almost intact.

> unfortunately broke the no MMU case.  Compile tested with allnoconfig and
> at91x40_defconfig on v3.10-rc6/v3.9.6 + ARM 7755/1.  On older stable kernels
> (3.2.47 & 3.4.49) compiled with at91x40_defconfig.

> - Simon

WBR, Sergei
