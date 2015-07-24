From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 24 Jul 2015 19:42:28 +0200
Subject: [PATCH 04/10] OPP: Break _opp_add_dynamic() into smaller functions
In-Reply-To: <15b69640a8672d983f2233e16e52ca275d36c816.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <15b69640a8672d983f2233e16e52ca275d36c816.1434369079.git.viresh.kumar@linaro.org>
Message-ID: <1576308.d9Ji59vHD1@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, June 15, 2015 05:27:30 PM Viresh Kumar wrote:
> Later commits would add support for new OPP bindings and this would be
> required then. So, lets do it in a separate patch to make it easily
> reviewable.
> 
> Another change worth noticing is INIT_LIST_HEAD(&opp->node). We weren't
> doing it earlier as we never tried to delete a list node before it is
> added to list. But this wouldn't be the case anymore. We might try to
> delete a node (just to reuse the same code paths), without it being
> getting added to the list.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
