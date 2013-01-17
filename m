From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:28:04 +0100
Subject: [PATCH] Proposed removal of IS_ERR_OR_NULL() (was: Re: [PATCH
 1/4] gpiolib: introduce descriptor-based GPIO interface)
In-Reply-To: <20130109150427.GL3931@n2100.arm.linux.org.uk>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
 <20130109150427.GL3931@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYgD67OA-gmxdwZJXhtjwk1sRnntCzh4Q2RHbhoQ6TUhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 4:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So, it seems there's some concensus building here, and it seems that
> I've become the chosen victi^wvolunteer for this.  So, here's a patch.
> It's missing a Guns-supplied-by: tag though.
>
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: Mark IS_ERR_OR_NULL() deprecated

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Following the tradition of computer science an alternate title of
the patch could be "IS_ERR_OR_NULL() considered harmful".

Yours,
Linus Walleij
