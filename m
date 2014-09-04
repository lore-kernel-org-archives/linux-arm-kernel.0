From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 04 Sep 2014 12:08:37 +0200
Subject: [PATCH 18/19] ARM: SAMSUNG: Remove remaining legacy code
In-Reply-To: <53C67783.4090407@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-19-git-send-email-t.figa@samsung.com>
 <1405506268.4408.28.camel@x220> <53C67783.4090407@samsung.com>
Message-ID: <1409825317.5546.94.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 15:00 +0200, Tomasz Figa wrote:
> On 16.07.2014 12:24, Paul Bolle wrote:
> > On Fri, 2014-07-04 at 19:48 +0200, Tomasz Figa wrote:
> >> -config S5P_GPIO_DRVSTR
> >> -	bool
> >> -	help
> >> -	  Internal configuration to get and set correct GPIO driver strength
> >> -	  helper
> >> -
> > 
> > This one is used (as a macro) in drivers/gpio/gpio-samsung.c. Is a patch
> > that touches that macro queued somewhere?
> 
> The code you mention should be removed as well as it's no longer needed.
> Will include in a follow-up series. Thanks for reporting this and
> remaining missed parts.

That check for CONFIG_S5P_GPIO_DRVSTR is still present in v3.17-rc3 and
next-20140903. Should I submit the trivial patch to remove it (and the
dead code it hides)?


Paul Bolle
