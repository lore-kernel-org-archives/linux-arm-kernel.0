From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 11 May 2012 12:12:33 +0200
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
Message-ID: <20120511101233.GH1214@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, May 04, 2012 at 07:23:21PM +0100, Lee Jones wrote:
> This patch will allow the ab8500-core driver to be probed and set up
> when booting when Device Tree is enabled. This includes platform ID
> look-up which identifies the machine it is currently running on. If
> we are undergoing a DT enabled boot, we will refuse to setup each of
> the other ab8500-* devices, as they will be probed individually by DT.
This one doesn't apply to my for-next branch. Which tree/branch did you use to
generate it ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
