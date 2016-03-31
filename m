From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 14:39:53 +0800
Subject: [PATCH] irqchip/mxs: fix error check of of_io_request_and_map()
In-Reply-To: <1457486500-10237-1-git-send-email-vz@mleia.com>
References: <1457486500-10237-1-git-send-email-vz@mleia.com>
Message-ID: <20160331063953.GS28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 03:21:40AM +0200, Vladimir Zapolskiy wrote:
> The of_io_request_and_map() returns a valid pointer in iomem region or
> ERR_PTR(), check for NULL always fails and may cause a NULL pointer
> dereference on error path.
> 
> Fixes: 25e34b44313b ("irqchip/mxs: Prepare driver for hardware with different offsets")
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
