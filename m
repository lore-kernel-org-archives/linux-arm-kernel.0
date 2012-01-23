From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 23 Jan 2012 16:36:29 +0400
Subject: [PATCH] ARM: GIC: fix non-SMP builds
In-Reply-To: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
References: <1327312291-9457-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F1D544D.8030702@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-01-2012 13:51, Marek Szyprowski wrote:

> This patch fixes the build break introduced by commit db0d4db22. It

    Please also specify the summary of that commit. Russell has recently again 
explained why it's needed.

> happen only if SMP support has been disabled:

> arch/arm/common/gic.c: In function 'gic_init_bases':
> arch/arm/common/gic.c:679: error: implicit declaration of function 'cpu_logical_map'
> make[1]: *** [arch/arm/common/gic.o] Error 1
> make: *** [arch/arm/common] Error 2

> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>

WBR, Sergei
