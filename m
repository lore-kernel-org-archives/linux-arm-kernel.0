From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue, 17 Apr 2012 15:36:34 +0300
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120417112910.GA3852@pengutronix.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <20120417112910.GA3852@pengutronix.de>
Message-ID: <20120417123633.GA7649@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Tue, Apr 17, 2012 at 01:29:10PM +0200, Sascha Hauer wrote:
> Your patches won't work when more than one USB port is enabled because
> of the singular usb transceiver present in the kernel. That of course is
> not your fault. I think Heikki (Added to Cc) is working on this issue,
> but I don't know the status here.

No I'm not working on multi PHY support. At one point I was thinking
about introducing a very basic support for it but it would not have
been enough for USB3 and OMAP4. I believe Kishon has been working on
this. Kishon?

-- 
heikki
