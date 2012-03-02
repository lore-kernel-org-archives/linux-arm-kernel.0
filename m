From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 2 Mar 2012 14:53:35 +0100
Subject: [PATCH 1/4] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
In-Reply-To: <1330421953-29517-2-git-send-email-rnayak@ti.com>
References: <1330421953-29517-1-git-send-email-rnayak@ti.com>
 <1330421953-29517-2-git-send-email-rnayak@ti.com>
Message-ID: <20120302135335.GS9008@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 28, 2012 at 03:09:10PM +0530, Rajendra Nayak wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> vdd1 and vdd2 are now common regulators for twl4030 and twl6030. Also
> added vdd3 as a new regulator for twl6030. twl6030 vdd1...vdd3 smps
> regulator voltages can only be controlled through the smartreflex
> voltage channel, thus the support for the voltage_get and set is
> minimal and requires external controller.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Mark, Liam, are you guys taking this one ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
