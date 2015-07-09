From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jul 2015 18:13:54 +0200
Subject: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2
 bindings
In-Reply-To: <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
Message-ID: <3095426.xc9msIINgb@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, June 15, 2015 05:27:36 PM Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.

I believe that following patches:

* [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
  (http://lkml.org/lkml/2015/7/9/420)

* [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
  (http://lkml.org/lkml/2015/7/9/421)

should be integrated into this patch series before patch #10 (the current
one) can be applied.

[ Please see http://lkml.org/lkml/2015/7/9/419 for more details. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
