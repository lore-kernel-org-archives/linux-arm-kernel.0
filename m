From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Dec 2014 12:15:16 -0500
Subject: [PATCH] ARM: configs: enable CPUFREQ_DT in multi_v7_defconfig
In-Reply-To: <1417540313-6359-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1417540313-6359-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141202171516.GZ22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Please re-send this to arm at kernel.org and include my Ack.

On Tue, Dec 02, 2014 at 06:11:53PM +0100, Thomas Petazzoni wrote:
> In commit bbcf071969b20 ("cpufreq: cpu0: rename driver and internals
> to 'cpufreq_dt'"), the generic cpufreq driver has been renamed, and
> its Kconfig option as well. Therefore, the multi_v7_defconfig should
> be updated accordingly, and enable CONFIG_CPUFREQ_DT instead of
> CONFIG_GENERIC_CPUFREQ_CPU0.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Commit based on arm-soc/next/defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
