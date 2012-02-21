From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 21 Feb 2012 15:02:59 +0100
Subject: [PATCH 1/2] GPIO: LPC32xx: Fix missing bit selection mask
In-Reply-To: <1329773948-4655-1-git-send-email-stigge@antcom.de>
References: <1329773948-4655-1-git-send-email-stigge@antcom.de>
Message-ID: <20120221140259.GB3162@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 10:39:07PM +0100, Roland Stigge wrote:
> Add missing mask to pin bit selection in gpio-lpc32xx.c
> (#define GPIO3_PIN_IN_SEL)
> 
> A table indentation change was necessary due to line length restrictions, but
> the only relevant change is the definition of GPIO3_PIN_IN_SEL.

I'd vote for violating the 80 char limit and keep the change minimal
here, i.e. change only the relevant define.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120221/6690580a/attachment-0001.sig>
