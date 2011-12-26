From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Dec 2011 11:29:32 +0000
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111226112931.GE8722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 09:16:28PM +0530, Thomas Abraham wrote:
> A device node pointer is added to generic pm domain structure to associate
> the domain with a node in the device tree. The platform code parses the
> device tree to find available nodes representing the generic power domain,
> instantiates the available domains and initializes them by calling
> pm_genpd_init().

This sounds useful but the binding needs to be documented properly.
