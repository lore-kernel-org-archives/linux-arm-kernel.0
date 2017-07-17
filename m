From: jdelvare@suse.de (Jean Delvare)
Date: Mon, 17 Jul 2017 10:06:58 +0200
Subject: [PATCH v4 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
In-Reply-To: <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
References: <cover.1499692967.git.sean.wang@mediatek.com>
 <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
Message-ID: <20170717100658.46898057@endymion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jul 2017 22:23:08 +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> single cluster and this hardware is also compatible with the existing
> driver through enabling CPU frequency feature with operating-points-v2
> bindings. Also, this driver actually supports all MediaTek SoCs, the
> Kconfig menu entry and file name itself should be updated with more
> generic name to drop "MT8173"
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Confirmed, looks good to me.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
