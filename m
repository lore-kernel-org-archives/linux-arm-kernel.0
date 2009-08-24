From: davem@davemloft.net (David Miller)
Date: Sun, 23 Aug 2009 22:57:43 -0700 (PDT)
Subject: [PATCH] pxaficp-ir - remove incorrect net_device_ops
In-Reply-To: <20090824043831.GA2473@orion>
References: <a4423d670908231055o2bb65fe0le2c33fe94b660b38@mail.gmail.com>
	<20090823.184924.26788268.davem@davemloft.net>
	<20090824043831.GA2473@orion>
Message-ID: <20090823.225743.135339409.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Mon, 24 Aug 2009 08:38:31 +0400

> Subject: [PATCH] pxaficp-ir - remove incorrect net_device_ops
> 
> This patch fixes broken pxaficp-ir. The problem was in incorrect
> net_device_ops being specified which prevented the driver from
> operating. The symptoms were:
>  - failing ifconfig for IrLAN, resulting in
> 	SIOCSIFFLAGS: Cannot assign requested address
>  - irattach working for IrCOMM, but the port stayed disabled
> 
> Moreover this patch corrects missing sysfs device link.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied, thanks.
