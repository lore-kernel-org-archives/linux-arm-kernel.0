From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Jun 2014 09:09:49 -0400
Subject: [PATCH Resend 2/8] ARM: mvebu: Staticize
 armada_375_smp_cpu1_enable_wa
In-Reply-To: <1403610235-22654-2-git-send-email-sachin.kamat@samsung.com>
References: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
 <1403610235-22654-2-git-send-email-sachin.kamat@samsung.com>
Message-ID: <20140624130949.GO10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 05:13:49PM +0530, Sachin Kamat wrote:
> From: Sachin Kamat <sachin.kamat@linaro.org>
> 
> 'armada_375_smp_cpu1_enable_wa' is local to this file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/mach-mvebu/platsmp-a9.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

patches 2, 3, and 4 applied to mvebu/soc

thx,

Jason.
