From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 21:55:49 -0700
Subject: [GIT PULL] at91: USBA DT support for 3.11
In-Reply-To: <20130526083430.GP24476@game.jcrosoft.org>
References: <20130526083430.GP24476@game.jcrosoft.org>
Message-ID: <20130601045549.GA4702@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 26, 2013 at 10:34:30AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Arnd, Olof
> 
> Second AT91 pull-request for 3.11
> 
> This add the DT support the USBA present in the most recents AT91 SoC
> As agree with Arnd and Filipe we send the drivers via arm-soc
> 
> this is base on previous pull request at91-3.11-cleanup1+resolved
> 
> Best Regards,
> J.
> 
> The following changes since commit 7a76f53b01685eda605fa15ccaa1ca90a7aa2c33:
> 
>   ARM: at91: udpate defconfigs (2013-05-24 18:02:06 +0200)

That is not the commit we have.  The one we have is:

commit b3f442b0eedbc20b5ce3f4a96530588d14901199
Author:     Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
AuthorDate: Wed May 15 17:19:21 2013 +0200
Commit:     Nicolas Ferre <nicolas.ferre@atmel.com>
CommitDate: Fri May 17 15:05:08 2013 +0200

So it looks like your version was rebased a week later than the one we have.

Please sort this out. Ideally by rebasing back to what we already have.


-Olof
