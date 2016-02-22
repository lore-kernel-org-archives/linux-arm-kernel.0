From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Mon, 22 Feb 2016 16:29:08 +0000
Subject: [PATCH 57/61] gpio: wm8350: Use devm_gpiochip_add_data() for
 gpio registration
In-Reply-To: <1456150130-2668-58-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
 <1456150130-2668-58-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160222162908.GB1490@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 07:38:46PM +0530, Laxman Dewangan wrote:
> Use devm_gpiochip_add_data() for GPIO registration and remove the
> need of driver callback .remove.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: patches at opensource.wolfsonmicro.com
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
