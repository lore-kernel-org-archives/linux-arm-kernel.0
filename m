From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 22:12:15 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
In-Reply-To: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
References: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Message-ID: <20170503141213.GJ18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02, 2017 at 05:46:00PM +0300, Leonard Crestez wrote:
> Enable more common cpufreq governors in imx defconfig because this is
> very useful for testing. In particular you can't use cpufreq-set -f
> $FREQ without explicitly defining CONFIG_CPU_FREQ_GOV_USERSPACE=y.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
