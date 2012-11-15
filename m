From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 15 Nov 2012 14:40:07 +0100
Subject: ttySAC0 or ttyS0 in 3.6.x ARM Linux?
In-Reply-To: <k824bb$7kp$1@ger.gmane.org>
References: <k824bb$7kp$1@ger.gmane.org>
Message-ID: <20121115134007.GB25895@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 03:07:24PM +0800, woody wrote:
> Hi,

Hi,

> In the 3.6.6 ARM kernel, should I use ttySAC0 or ttyS0 to specify
> the 'console' kernel command line?

it depends on the driver used for your console. ttySAC is Samsung. which
kind of uart do you have?

Regards,
Domenico
