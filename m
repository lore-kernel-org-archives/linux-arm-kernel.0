From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 21:24:31 +0000 (UTC)
Subject: [PATCH RESEND 3/5] ARM: OMAP2+: AM33XX: Add clock entries to
 omap_clk data
In-Reply-To: <1348089570-16161-4-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
 <1348089570-16161-4-git-send-email-anilkumar@ti.com>
Message-ID: <alpine.DEB.2.00.1209192124090.5264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 20 Sep 2012, AnilKumar Ch wrote:

> Add AM335x cpu0 clock entry to the corresponding clock data
> file. This is useful in getting the correct mpu clock pointer
> to change the cpu frequency in cpufreq driver.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks like this one is unrelated to the DTS changes, so I'll queue it 
separately here for 3.7.

- Paul
