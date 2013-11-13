From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Nov 2013 23:46:20 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_HIGHMEM
In-Reply-To: <1384295952-10619-1-git-send-email-festevam@gmail.com>
References: <1384295952-10619-1-git-send-email-festevam@gmail.com>
Message-ID: <20131113154544.GH17816@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 08:39:12PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Booting a mx6q wandboard with 2GB of RAM we see the following on boot:
> 
> Booting Linux on physical CPU 0x0                                               
> Linux version 3.12.0-next-20131112+ (fabio at fabio-Latitude-E6410) (gcc version 43
> CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d                
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache        
> Machine model: Wandboard i.MX6 Quad Board                                       
> Truncating RAM at 10000000-8fffffff to -7f7fffff (vmalloc region overlap)
> ...
> 
> Select CONFIG_HIGHMEM to avoid the vmalloc region overlap.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
