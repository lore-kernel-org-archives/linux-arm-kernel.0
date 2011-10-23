From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 23 Oct 2011 11:02:47 +0200
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
In-Reply-To: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
References: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
Message-ID: <20111023090247.GH2638@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:18 Sun 23 Oct     , Zoltan Devai wrote:
> Hi,
> 
> Originally, I just wanted to get rid of arch_decomp_* in all the uncompress.h
> files, that were mostly empty. But then, I couldn't stop. Which may also mean
> I have gone too far.
on small SoC arm926 the kernel may more time that the watchdog refreshing so
the kernel will never have enough time to decompress

and on some platform the watchdog can be configured only one (AT91 as example)

Best Regards,
J.
