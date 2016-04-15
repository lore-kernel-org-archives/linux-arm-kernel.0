From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 15 Apr 2016 08:48:44 +0200
Subject: [PATCH RFT 3/5] iio: mxs-lradc: move STMP reset out of ADC init
In-Reply-To: <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
 <1460648909-2657-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201604150848.44242.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Thursday 14 April 2016 17:48:27 Stefan Wahren wrote:
> This patch moves the STMP reset out of ADC init function
> in order to make it never fail. This is also necessary
> for PM ops.

What do you mean with "make it never fail"?

> [...]

jb
