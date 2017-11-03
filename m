From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 3 Nov 2017 14:56:39 +0000
Subject: [PATCH v4 15/20] firmware: arm_scmi: add device power domain
 support using genpd
In-Reply-To: <1509720477-18936-16-git-send-email-sudeep.holla@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-16-git-send-email-sudeep.holla@arm.com>
Message-ID: <3ea7b655-b2d6-4d61-b0c5-bafd96409e31@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 03/11/17 14:47, Sudeep Holla wrote:
> This patch hooks up the support for device power domain provided by
> SCMI using the Linux generic power domain infrastructure.
> 
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

Sorry for not adding you Reviewed-by tag along with dev_warn suggestion
you gave. I seem to have lost that change locally somehow. I have fixed
it now.

-- 
Regards,
Sudeep
