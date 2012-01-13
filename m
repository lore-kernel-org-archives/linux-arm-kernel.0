From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 13 Jan 2012 18:16:18 +0100
Subject: [PATCH V6 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <874nw0sfdn.fsf@ti.com>
References: <1325213769-11752-1-git-send-email-richard.zhao@linaro.org>
 <1325213769-11752-5-git-send-email-richard.zhao@linaro.org>
 <87aa5t25ad.fsf@ti.com> <20120112082300.GF2414@b20223-02.ap.freescale.net>
 <874nw0sfdn.fsf@ti.com>
Message-ID: <4F1066E2.1020804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/12/2012 11:52 PM, Kevin Hilman wrote:
> Richard Zhao<richard.zhao@freescale.com>  writes:

[...]

>> Do you have real case to need different voltage/clk?
>
> Sure, any system with independently scalable CPUs/clusters.

AFAIK, in the ARM SoC world there is a least the MSM8660 that does 
support that today.

Regards,
Benoit
