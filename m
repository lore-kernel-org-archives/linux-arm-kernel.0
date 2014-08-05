From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 5 Aug 2014 15:24:02 +0300
Subject: [PATCH v2 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
In-Reply-To: <1407241137-32232-5-git-send-email-mperttunen@nvidia.com>
References: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com>
 <1407241137-32232-5-git-send-email-mperttunen@nvidia.com>
Message-ID: <53E0CCE2.4050008@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/14 15:18, Mikko Perttunen wrote:
> This adds support for the Tegra SOCTHERM thermal sensing and management
> system found in the Tegra124 system-on-chip. This initial driver supports
> the four thermal zones with hardware-tracked trip points.

.. does NOT support hardware-tracked trip points. I guess you always 
have to have at least one little mistake there.

Mikko

>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> ...
