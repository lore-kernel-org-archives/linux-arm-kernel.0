From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 18:50:38 +0200
Subject: [PATCH V2 11/11] cpufreq-dt: Add support for operating-points-v2
 bindings
In-Reply-To: <1fb2b7a67ac2a7fb6390401eef529bd14eec8f43.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <1fb2b7a67ac2a7fb6390401eef529bd14eec8f43.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <2884444.cGlkETteRY@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 10:32:41 AM Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.
> 
> For backward compatibility we will continue to support earlier bindings.
> Special handling for that is required, to make sure OPPs are initialized
> for all the CPUs.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
