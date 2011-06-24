From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Fri, 24 Jun 2011 21:53:03 +0200
Subject: I can' t compile a new kernel version
In-Reply-To: <1308940265.2194.77.camel@sacarino>
References: <1308940265.2194.77.camel@sacarino>
Message-ID: <20110624195303.GF5713@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 08:31:05PM +0200, Jorge Yesid Rios Ortiz wrote:
> I tried update many times the linux's kernel and different versions of
> kernels
...
> I download different versions of ARM's toolchains (like code sourcery
> lite version http://www.codesourcery.com/sgpp/lite/arm and others
> more), this toolchains isn't working for me and my embedded system.

What did you compile with which toolchain, and what happened (which you
describe as "isn't working")?

I assume you have sources for your Linux 2.6.16 and can build it with
your gcc 3.3.2, and it actually boots.

I think you'll need to port your board support to the stock kernel,
otherwise it isn't going to work.

With kind regards,
Baurzhan.
