From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 10:22:08 -0300
Subject: [PATCH 4/4] pinctrl: mvebu: add missing iounmap
In-Reply-To: <1377175611-4241-5-git-send-email-jszhang@marvell.com>
References: <1377175611-4241-1-git-send-email-jszhang@marvell.com>
 <1377175611-4241-5-git-send-email-jszhang@marvell.com>
Message-ID: <20130822132207.GA27167@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Thu, Aug 22, 2013 at 08:46:51PM +0800, Jisheng Zhang wrote:
> Add missing iounmap to prove error path and remove path
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

How about using devm_ioremap_resource() instead?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
