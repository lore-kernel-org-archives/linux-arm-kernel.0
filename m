From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 26 Apr 2018 14:56:32 +0530
Subject: [PATCH 10/11] soundwire: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-11-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180426092632.GU6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:53:09AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
