From: sivaramn@nvidia.com (Sivaram Nair)
Date: Mon, 22 Aug 2016 17:12:20 -0700
Subject: [PATCH v3 02/12] mailbox: Add Tegra HSP driver
In-Reply-To: <20160819173233.13260-3-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-3-thierry.reding@gmail.com>
Message-ID: <20160823001220.GB4932@kickseed.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 07:32:23PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#define DEBUG

Is this a leftover from your debugging (elsewhere in this series too)?

> +
> +#include <linux/interrupt.h>
