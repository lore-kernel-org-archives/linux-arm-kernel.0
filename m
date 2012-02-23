From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 09:58:14 +0000
Subject: [PATCH 1/2] GPIO: LPC32xx: Fix missing bit selection mask
In-Reply-To: <20120221140259.GB3162@pengutronix.de>
References: <1329773948-4655-1-git-send-email-stigge@antcom.de>
 <20120221140259.GB3162@pengutronix.de>
Message-ID: <201202230958.14801.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Wolfram Sang wrote:
>   Show Details
>   On Mon, Feb 20, 2012 at 10:39:07PM +0100, Roland Stigge wrote:
> > Add missing mask to pin bit selection in gpio-lpc32xx.c
> > (#define GPIO3_PIN_IN_SEL)
> > 
> > A table indentation change was necessary due to line length restrictions, but
> > the only relevant change is the definition of GPIO3_PIN_IN_SEL.
> 
> I'd vote for violating the 80 char limit and keep the change minimal
> here, i.e. change only the relevant define.

Yes, that would be better. Another option would be to send two patches, but
I would not bother with that.

	Arnd
