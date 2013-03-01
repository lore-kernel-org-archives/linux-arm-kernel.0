From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 01 Mar 2013 13:13:58 -0700
Subject: [PATCH v4 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
 <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51310C06.2090909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
