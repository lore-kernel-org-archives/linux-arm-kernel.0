From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 24 Jun 2015 18:36:48 +0530
Subject: [PATCH 07/17] usb: musb: omap2430: use *syscon* framework to
 write to mailbox register
In-Reply-To: <20150624114907.GF4156@atomide.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-8-git-send-email-kishon@ti.com>
 <20150624114907.GF4156@atomide.com>
Message-ID: <558AAB68.3090205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 24 June 2015 05:19 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150623 05:02]:
>> Deprecate using phy-omap-control driver to write to the mailbox register
>> and start using *syscon* framework to do the same.
> 
> All this stuff needs to go to some generic syscon USB phy
> driver. Let's not start adding phy specific stuff to a USB
> driver.

Mailbox register is actually part of OMAP USB glue that should be written in
order to inform the usbmode to the MUSB core.

Thanks
Kishon
