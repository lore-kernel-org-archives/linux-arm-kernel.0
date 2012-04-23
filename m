From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 23 Apr 2012 18:42:12 +0200
Subject: [PATCHv8 09/10] I2C: OMAP: Do not set the XUDF if the underflow
 is not reached
In-Reply-To: <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120423164212.GC27321@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 06:58:20PM +0530, Shubhrajyoti D wrote:
> Currently in the 1.153 errata handling while waiting for transmitter
> underflow if NACK is got the XUDF flag is also set.
> The flag is set after wait for the condition is over.

What does XUDF mean? Please update the commit description, I can't know
all terminology for all architectures.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120423/a25575d6/attachment-0001.sig>
