From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 21 Oct 2013 20:41:00 +0000
Subject: [PATCH 2/2 v4] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <20131019212213.GA5341@kroah.com>
References: <201310171329.12434.hartleys@visionengravers.com>
 <20131019212213.GA5341@kroah.com>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DB9D93@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 19, 2013 2:22 PM, Greg KH wrote:
> On Thu, Oct 17, 2013 at 01:29:11PM -0700, H Hartley Sweeten wrote:
>> Convert ep93xx to use the OHCI platform driver and remove the
>> ohci-ep93xx bus glue driver.
>> 
>> Enable CONFIG_OHCI_HCD_PLATFORM in the ep93xx_defconfig so that USB
>> is still enabled by default on the EP93xx platform.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

[snip]

> This patch doesn't apply to my usb-next branch of usb.git at all, what
> happened?  Did Alan's other recent changes interfere with this?
>
> Can you refresh this against my tree and resend it so that I can apply
> it?  I've applied the 1/2 patch already.

Greg,

I just refreshed this patch against usb-next and sent it as v5.

Thanks,
Hartley
