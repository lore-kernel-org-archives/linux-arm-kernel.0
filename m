From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 10 Sep 2018 12:32:35 -0700
Subject: Regression in next with filesystem context concept
In-Reply-To: <20180910192658.GX5662@atomide.com>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
 <20180910160836.GT5662@atomide.com>
 <20180910183146.GA17726@roeck-us.net>
 <20180910192658.GX5662@atomide.com>
Message-ID: <20180910193235.GA8769@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 12:26:58PM -0700, Tony Lindgren wrote:
> * Guenter Roeck <linux@roeck-us.net> [180910 18:35]:
> > On Mon, Sep 10, 2018 at 09:08:36AM -0700, Tony Lindgren wrote:
> > > OK thanks for tracking that down, next-20180910 boots again
> > > for me.
> > > 
> > 
> > Did you try to shutdown and/or reboot ?
> > 
> > You might see something like the attached if you try.
> 
> Hmm not seeing that here with next-20180910 on ARM at least.
> 

Correct, the problem doesn't happen on arm. That is the one
and only exception as far as I can see.

On arm, the only boot failure is witherspoon-bmc with
aspeed_g5_defconfig, but that doesn't crash but simply hang
during boot.

arm64 still fails to build, so I don't have any data there.

Guenter
