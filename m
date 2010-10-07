From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 7 Oct 2010 05:03:49 -0700 (PDT)
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101007074853.GZ28242@pengutronix.de>
Message-ID: <383990.86918.qm@web51007.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

>  +?? void __iomem *usbother_base;
>  +??? usb_base =  ioremap(MX51_OTG_BASE_ADDR, SZ_4K);

Shouldn't you check whether ioremap failed?

Regards,

Fabio Estevam



      
