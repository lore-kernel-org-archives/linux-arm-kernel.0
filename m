From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 12 Jan 2016 03:54:31 -0800
Subject: [PATCH v2 1/1] USB: core: let USB device know device node
In-Reply-To: <1452594758-23417-1-git-send-email-peter.chen@freescale.com>
References: <1452594758-23417-1-git-send-email-peter.chen@freescale.com>
Message-ID: <2243040.bqZF27Q8z8@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 12, 2016 06:32:38 PM Peter Chen wrote:
> descirbe these at device tree.
s/descirbe/describe/

...by the way
I no longer see any reference to a reset GPIO.
Did that get moved to u-boot, and if so is that posted somewhere?

I'm curious because I've got a board (not yet mainlined) with one of
these onboard hubs that is currently using the fake regulator hack.
I want to test your patch(es). 
