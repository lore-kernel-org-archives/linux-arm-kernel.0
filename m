From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 3 Jan 2017 10:24:05 +0100
Subject: [PATCH] serial: mxs-auart: support CMSPAR termios cflag
In-Reply-To: <20161212072101.9909-1-weo@reccoware.de>
Message-ID: <bd44dfdb-7266-f7f0-4f17-066d79d14ebf@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfgang,

> If CMSPAR is set in the c_cflag of termios, "stick" parity is enabled.

you can have my

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

for this version 2 from 12.12.2016.

But in order to increase the chance that your patch get merged, please
resend your patch:
* with the correct version in your subject line
* not during the merge window
* with my Acked-by
* with a copy to linux-serial at vger.kernel.org

Thanks
Stefan
