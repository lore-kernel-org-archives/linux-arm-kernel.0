From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Sat, 15 Sep 2018 15:46:01 +0200
Subject: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
In-Reply-To: <20180914101339.7382-2-romain.izard.pro@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
 <20180914101339.7382-2-romain.izard.pro@gmail.com>
Message-ID: <20180915134601.GA947@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 12:13:38PM +0200, Romain Izard wrote:
> When using watchdog_init_timeout to update the default timeout value,
> an error means that there is no "timeout-sec" in the relevant device
> tree node.
> 
> This should not prevent binding of the driver to the device.
> 
> Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provided in devicetree")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
