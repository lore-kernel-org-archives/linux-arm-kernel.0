From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Nov 2010 09:10:48 +0100
Subject: Calling conventions for IAR
In-Reply-To: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
References: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
Message-ID: <20101118081048.GH8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 04:29:36PM -0500, jonsmirl at gmail.com wrote:
> Currently we are using the ARM gcc AAPCS calling conventions. I need
> to call into an older ROM written with an IAR compiler. Can I decorate
> the function declarations for older calling conventions like I do on
> x86 (_fastcall, _cdelc, _stdcall, etc)? I can't figure out the right
> thing to search for, what's a good keyword?
I don't know if something like this exists and I don't now either which
calling convention is used by an IAR compiler.

I'd just call the ROM functions using an asm (or inline-asm) stub if
it's different enough not to be directly callable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
