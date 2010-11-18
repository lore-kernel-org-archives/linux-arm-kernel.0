From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Nov 2010 09:26:20 +0000
Subject: Calling conventions for IAR
In-Reply-To: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
References: <AANLkTikxL8qhzh=9DMkyJCVtAuWoq9Z__xj3up+KQhXA@mail.gmail.com>
Message-ID: <20101118092620.GB16907@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 04:29:36PM -0500, jonsmirl at gmail.com wrote:
> Currently we are using the ARM gcc AAPCS calling conventions. I need
> to call into an older ROM written with an IAR compiler. Can I decorate
> the function declarations for older calling conventions like I do on
> x86 (_fastcall, _cdelc, _stdcall, etc)? I can't figure out the right
> thing to search for, what's a good keyword?

I think you're out of luck... you're probably better off writing some
glue assembler code to call these functions.
