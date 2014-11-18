From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Nov 2014 21:08:29 +0530
Subject: [PATCH] davinci: Use standard logging styles
In-Reply-To: <1414803111.13647.13.camel@perches.com>
References: <1414803111.13647.13.camel@perches.com>
Message-ID: <546B67F5.20108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 November 2014 06:21 AM, Joe Perches wrote:
> Convert printks to pr_<level> and pr_warning to pr_warn.
> 
> Other miscellanea:
> 
> o Coalesce formats
> o Realign arguments
> o Use %s, __func__ instead of embedded function names
> o Add pr_fmt to mityomapl138 and mux
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Sending to ARM-SoC for v3.19. Prefixed subject line with ARM: as is the
convention.

Thanks,
Sekhar
