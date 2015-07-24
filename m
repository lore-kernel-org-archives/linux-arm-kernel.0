From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 24 Jul 2015 19:25:51 +0200
Subject: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
In-Reply-To: <20150703064554.GB4564@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <5595CD68.9040701@codeaurora.org> <20150703064554.GB4564@linux>
Message-ID: <11329348.G3iY8nuDiD@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Friday, July 03, 2015 12:15:54 PM Viresh Kumar wrote:
> On 02-07-15, 16:46, Stephen Boyd wrote:
> > Looking better.
> 
> And does this look perfect ? :)
> 
> ------------------8<----------------
> 
> Message-Id: <7c23b93b6b328e0b14b5c5096c3c3322e3d8ee4b.1435905782.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 12 Jun 2015 12:43:14 +0530
> Subject: [PATCH] OPP: Allocate dev_opp from _add_device_opp()
> 
> There is no need to complicate _opp_add_dynamic() with allocation of
> dev_opp as well. Allocate it from _add_device_opp() instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
