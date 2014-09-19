From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 19 Sep 2014 11:48:49 -0700
Subject: [PATCH v5 00/11] PM / Domains: Generic OF-based support
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140919184849.GA14832@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, Sep 19, 2014 at 08:27:33PM +0200, Ulf Hansson wrote:
> Changes in v5:
> 	- Converted dev_pm_domain_detach() to a void function
> 	- Added a ->detach() callback to the PM domain struct, invoked from the
> 	  dev_pm_domain_detach().
> 	- Make ACPI and genpd both assign the ->detach() callback at successfull
> 	  attachment.
> 	- The above changes made it possible to make acpi_pm_domain_detach() to
> 	  be static, added a separate patch for that.

Thank you for making these changes. For the series:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
