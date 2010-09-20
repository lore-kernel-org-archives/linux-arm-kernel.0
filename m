From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 20 Sep 2010 16:46:34 +0200
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
In-Reply-To: <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
	<1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
	<20100916090018.GM3393@legolas.emea.dhcp.ti.com>
	<4C91DF66.6020003@compulab.co.il>
	<20100920063913.GB32493@legolas.emea.dhcp.ti.com>
Message-ID: <4C9773CA.4010102@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 09/20/10 08:39, Felipe Balbi wrote:
> On Thu, Sep 16, 2010 at 04:12:06AM -0500, Igor Grinberg wrote:
>> Yes it will, but even if the hub reset gpio is for some reason unavailable,
>> we don't want to disable ehci completely...
>
> then you should set the gpio to an invalid number, otherwise you might
> cause lots of WARN() to appear due to fiddling with unrequested gpio.

What gpio should be set to invalid number?
It is a reset gpio for usb _hub_ and it has nothing to do with ehci.
Can you please, explain the case when I might cause those WARN()'s?

-- 
Regards,
Igor.
