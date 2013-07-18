From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 11:06:51 -0600
Subject: [PATCH] reset: allow drivers to request probe deferral
In-Reply-To: <1374148653-14009-1-git-send-email-p.zabel@pengutronix.de>
References: <1374148653-14009-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51E820AB.1040008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2013 05:57 AM, Philipp Zabel wrote:
> If the requested reset controller is not yet available, have reset_control_get
> and device_reset return -EPROBE_DEFER so the driver can decide to request
> probe deferral.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
