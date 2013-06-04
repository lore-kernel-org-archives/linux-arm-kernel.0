From: b32955@freescale.com (Huang Shijie)
Date: Tue, 4 Jun 2013 10:12:43 +0800
Subject: [PATCH] serial: imx: enable the clocks only when the uart is used
In-Reply-To: <20130603095014.GJ18614@n2100.arm.linux.org.uk>
References: <1370245331-12501-1-git-send-email-b32955@freescale.com>
 <20130603095014.GJ18614@n2100.arm.linux.org.uk>
Message-ID: <51AD4D1B.5020106@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?06?03? 17:50, Russell King - ARM Linux ??:
> You should check the return value.  I've a good mind to mark these
> functions with __must_check...
yes, that's a good idea to add the __must_check.

thanks
Huang Shijie
