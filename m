From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 08:58:35 +0100
Subject: [PATCH] leds-class: change back LEDS_CLASS to tristate instead
	of bool
In-Reply-To: <CAK5ve-KoanwFGFJcxGQGmAW0yR+MYR1uVGM5q+=8u_ofHrhwOQ@mail.gmail.com>
References: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
	<CAK5ve-KoanwFGFJcxGQGmAW0yR+MYR1uVGM5q+=8u_ofHrhwOQ@mail.gmail.com>
Message-ID: <20110929075835.GA26328@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:00:58AM +0800, Bryan Wu wrote:
> Hiya,
> 
> Any comments and need I do anything to improve this patch?

No idea, I don't remember the original errors which this stuff spat out
and how they were caused.

The only thing I care about is that the conversion of the existing ARM
LEDs support to the NEW_LEDS stuff doesn't cause any breakage.
