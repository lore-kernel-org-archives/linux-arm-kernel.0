From: eric@anholt.net (Eric Anholt)
Date: Fri, 06 Jan 2017 10:15:00 -0800
Subject: [PATCH v2 2/4] watchdog: bcm2835_wdt: Use watchdog core to
 install restart handler
In-Reply-To: <1483674720-4870-2-git-send-email-linux@roeck-us.net>
References: <1483674720-4870-1-git-send-email-linux@roeck-us.net>
 <1483674720-4870-2-git-send-email-linux@roeck-us.net>
Message-ID: <87a8b4njh7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guenter Roeck <linux@roeck-us.net> writes:

> Use the infrastructure provided by the watchdog core to install
> the restart handler.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Need to call watchdog_set_restart_priority()

Seems fine.

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/394426ae/attachment.sig>
