From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 08 Apr 2013 19:01:02 +0900
Subject: [PATCH] ARM: S3C24XX: Remove unused GPIO drive strength register
 definitions
In-Reply-To: <1365366588-19517-1-git-send-email-s.nawrocki@samsung.com>
References: <1365366588-19517-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <2cd801ce343f$fa20a330$ee61e990$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> There is currently no users of these definitions so remove them.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c24xx/regs-dsc.h |  203 +--------------------------------
> -----
>  1 files changed, 4 insertions(+), 199 deletions(-)
> 
Thanks for your cleanup ;-)

Applied.

- Kukjin
