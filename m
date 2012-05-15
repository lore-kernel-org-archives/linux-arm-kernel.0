From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 14:13:04 +0000
Subject: [PATCH 00/12] pinctrl for Ux500 and Nomadik family
In-Reply-To: <CACRpkdbjCBi2tkPE-yV7NdHOsMZ_XHuHr3nDUnRekxDDoqRRfw@mail.gmail.com>
References: <1336470214-23407-1-git-send-email-linus.walleij@stericsson.com>
 <201205151246.45384.arnd@arndb.de>
 <CACRpkdbjCBi2tkPE-yV7NdHOsMZ_XHuHr3nDUnRekxDDoqRRfw@mail.gmail.com>
Message-ID: <201205151413.04763.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Linus Walleij wrote:
> On Tue, May 15, 2012 at 2:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > One option would be that you just try to be very early with sending your
> > branch and arm-soc goes directly after that, another option would be that
> > we send a pull request for your tree along with the stuff that depends on
> > it, with your permission.
> 
> Either way is fine with me, I was planning to send a pull request as soon
> as the merge window opens anyway. If you need it, I can lock down the
> pinctrl tree and prepare the pull tag.

Ok, that's good then. I guess we can just wait until your pull request is
out and put a note in the ones from arm-soc that depend on it.

	Arnd
