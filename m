From: stigge@antcom.de (Roland Stigge)
Date: Mon, 27 Feb 2012 16:37:03 +0100
Subject: [PATCH v2 5/6] ARM: LPC32xx: serial.c: HW bug workaround
In-Reply-To: <20120227141430.GB3550@pengutronix.de>
References: <1330184118-10270-1-git-send-email-stigge@antcom.de>
 <1330184118-10270-6-git-send-email-stigge@antcom.de>
 <20120227141430.GB3550@pengutronix.de>
Message-ID: <4F4BA31F.8040201@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 02/27/2012 03:14 PM, Wolfram Sang wrote:
> If you have a reference (errata ID or similar) it would be nice to
> have it in the comment and description.

Can you please help out with this one?

In the LPC32xx errata, there is a note about a similar HS UART issue,
but this one here (Standard UART) must be a different one (or it's a
bug and the fix is actually targeted at HS UART).

I actually just ported this code from lpclinux.com and assumed that
NXP knows best about LPC HW bugs. ;-)

Thanks in advance,

Roland
