From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jul 2014 08:49:49 -0400
Subject: [PATCHv3 7/7] ARM: configs: add cpufreq-generic in
 multi_v7_defconfig
In-Reply-To: <1404920715-19834-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404920715-19834-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140716124949.GW13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 05:45:15PM +0200, Thomas Petazzoni wrote:
> The cpufreq-generic driver is going to be used by more and more
> platforms to support dynamic frequency scaling of the CPU. This commit
> enables this driver by default in multi_v7_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please re-send to arm-soc maintainers for them to apply directly.

thx,

Jason.
