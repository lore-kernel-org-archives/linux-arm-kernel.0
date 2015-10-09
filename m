From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 20:26:07 +0200
Subject: [PATCH] ARM: hisilicon: DT: Drop console= and earlyprintk
 bootargs parameter
In-Reply-To: <5617E6FC.6090304@hisilicon.com>
References: <5617E6FC.6090304@hisilicon.com>
Message-ID: <9558245.SAyWiXU6Yf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 17:10:36 Wei Xu wrote:
> Replace console with stdout-path so that we don't have to put the
> console on the kernel command line.
> 
> Remove earlyprintk to allow the kernel to boot on a system even
> if DEBUG_LL is configured for another system.
> 
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 

Looks good to me. Do you want us to apply the patch directly, or
do you plan to send a pull request?

	Arnd
