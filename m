From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 29 Sep 2016 10:05:58 +0200
Subject: [PATCH] MAINTAINERS: update entry for atmel_serial driver
In-Reply-To: <3dc3a39b-5cae-1ad1-df44-bed4703121c3@atmel.com>
References: <20160928154735.25265-1-nicolas.ferre@atmel.com>
 <20160929063148.GA418@kroah.com>
 <3dc3a39b-5cae-1ad1-df44-bed4703121c3@atmel.com>
Message-ID: <20160929080557.GA3406@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 09:37:46AM +0200, Nicolas Ferre wrote:
> Le 29/09/2016 ? 08:31, Greg Kroah-Hartman a ?crit :
> > On Wed, Sep 28, 2016 at 05:47:35PM +0200, Nicolas Ferre wrote:
> >> Change maintainer for the serial driver found on most of the
> >> Microchip / Atmel MPUs and take advantage of the move to rename
> >> and reorder the entry.
> >> I'm happy that Richard is taking over the maintenance of this
> >> driver.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> >> ---
> >>  MAINTAINERS | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > This doesn't apply to my tty-next tree at all, what did you make it
> > against?
> 
> Yesterdays' linux-next (next-20160928 tag). I thought it would be the
> best for easy pick-up by anybody, particularly on a highly shared file
> like MAINTAINERS.
> 
> Tell me if you want me to collect all tags, rebase on tty-next and re-send.

It's ok, I've fixed it up by hand, it's a tough file to handle at times
with lots of different trees touching it like you mention.

greg k-h
