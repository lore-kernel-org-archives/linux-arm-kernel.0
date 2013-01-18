From: stigge@antcom.de (Roland Stigge)
Date: Fri, 18 Jan 2013 14:18:23 +0100
Subject: [PATCH RESEND 1/6 v13] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CAOY=C6EE1yxjxUR6XvxW5tbY8FPBeO2Nqo6wMeD5R3zAVYD+Ag@mail.gmail.com>
References: <1358250716-21986-1-git-send-email-stigge@antcom.de>
 <1358250716-21986-2-git-send-email-stigge@antcom.de>
 <CAOY=C6EE1yxjxUR6XvxW5tbY8FPBeO2Nqo6wMeD5R3zAVYD+Ag@mail.gmail.com>
Message-ID: <50F94B9F.7020908@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stijn,

On 01/18/2013 01:13 PM, Stijn Devriendt wrote:
> Hi Roland,
> 
> This mail has been long overdue due to issues with some internal
> permission-tool.
> Just to be clear, this is not a competing implementation, it's what we
> currently use as-is. I'm just posting this as a reference to see if
> perhaps more concepts could be reused. It's based on a 2.6.32 kernel.
> 
> It includes:
> - labels in sysfs (to provide useful names to userspace)
> - gpio group support
> - exporting individual/groups of gpios dictated by platform-data or device-tree
> - open-drain support (different from mainline)
> - examplary support for multi-gpio to pcf8575 driver
> - gpio_direction_output_keep() function that prevents toggling when
> changing direction
> 
> Provided-as-is-by: Stijn Devriendt <sdevrien@cisco.com>

Thanks for posting.

Except for open-drain support, everything in the above list is supported
in the last posted version of block GPIO.

So please tell if there are certain details you would like to discuss
about or need an alternative implementation.

Thanks in advance,

Roland
