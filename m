From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 23 Apr 2012 22:59:22 +0530
Subject: [PATCHv8 09/10] I2C: OMAP: Do not set the XUDF if the underflow
 is not reached
In-Reply-To: <20120423164212.GC27321@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-10-git-send-email-shubhrajyoti@ti.com>
 <20120423164212.GC27321@pengutronix.de>
Message-ID: <4F959172.7080302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012 10:12 PM, Wolfram Sang wrote:
> On Thu, Apr 19, 2012 at 06:58:20PM +0530, Shubhrajyoti D wrote:
>> Currently in the 1.153 errata handling while waiting for transmitter
>> underflow if NACK is got the XUDF flag is also set.
>> The flag is set after wait for the condition is over.
> What does XUDF mean? Please update the commit description, I can't know
> all terminology for all architectures.
>
Transmitter underflow ,will update the commit description and resend.
