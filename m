From: linuxzsc@gmail.com (Richard Zhao)
Date: Wed, 27 Jun 2012 20:42:36 +0800
Subject: [PATCH 0/3] usb: chipidea: fix error handling and add dr_role
 property
In-Reply-To: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
References: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120627124233.GA2256@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 02:21:47PM +0200, Marc Kleine-Budde wrote:
> Hello,
> 
> while hacking on the chipidea driver, I fixed the error path in
> the udc part of the chipidea driver. Further I added the possibility
> to limit the driver to host or device only mode. It's possible via
> platformdata and device tree. For dt I selected the dr_role property
> which is already used for other dual role usb drivers.
What's it based on then?

Thanks
Richard
> 
> regards, Marc
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
