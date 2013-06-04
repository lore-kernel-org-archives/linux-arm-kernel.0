From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 13:12:44 -0400
Subject: [PATCH] cpufreq: kirkwood: Select CPU_FREQ_TABLE option
In-Reply-To: <1370365398-484-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370365398-484-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130604171244.GF3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:03:18PM -0300, Ezequiel Garcia wrote:
> We need to select CPU_FREQ_TABLE in order to build without
> this kind of errors:
> 
> drivers/built-in.o: In function `kirkwood_cpufreq_cpu_exit':
> /home/zeta/linux-devel/marvell-legacy/drivers/cpufreq/kirkwood-cpufreq.c:145:
> undefined reference to `cpufreq_frequency_table_put_attr'
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)

Hmm, I could've sworn I saw a patch for this floating around...

At any rate,

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
