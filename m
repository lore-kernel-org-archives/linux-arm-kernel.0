From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 16:23:12 +0200
Subject: [PATCH V2 06/11] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <f2267207114646280c5fd0e066d2b99f59a3c2e8.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
 <f2267207114646280c5fd0e066d2b99f59a3c2e8.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <1447859.StpgrO19qi@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 10:32:36 AM Viresh Kumar wrote:
> This adds support in OPP library to parse and create list of OPPs from
> operating-points-v2 bindings. It takes care of most of the properties of
> new bindings (except shared-opp, which will be handled separately).
> 
> For backward compatibility, we keep supporting earlier bindings. We try
> to search for the new bindings first, in case they aren't present we
> look for the old deprecated ones.
> 
> There are few things marked as TODO:
> - Support for multiple OPP tables
> - Support for multiple regulators
> 
> They should be fixed separately.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
