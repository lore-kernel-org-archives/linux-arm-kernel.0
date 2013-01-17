From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 16 Jan 2013 18:33:31 -0800
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <CACRpkdbnyzppd-iom4PL3N3-YkuK+BRNzR577qVc6cPoTKxhTw@mail.gmail.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
 <CACRpkdZ0b=ZohgaBH3qPH_O5TiWmXJXs6872D+YPVA9g4BssYg@mail.gmail.com>
 <9702060.jEbHySsCv0@avalon>
 <CACRpkdbFH6RCEEnXO=A9FVa0B5rtE9RkjXz9Hhy+w7NvwcBCgg@mail.gmail.com>
 <50F6E811.2040606@wwwdotorg.org>
 <CACRpkdbnyzppd-iom4PL3N3-YkuK+BRNzR577qVc6cPoTKxhTw@mail.gmail.com>
Message-ID: <20130117023331.GC20928@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 01:59:52AM +0100, Linus Walleij wrote:
> On Wed, Jan 16, 2013 at 6:49 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > Hmm. It's causing a lot of engineers here a lot of trouble, since they
> > all see linux-next won't boot, and haven't been paying enough attention
> > to know which commit to revert:-(. Lots of lost productivity:-(
> >
> > Simon, the offending commit:
> >
> > 6d3ef6b drivers/pinctrl: grab default handles from device core
> >
> > is still in next-20130116. Can you please remove it?
> 
> Not that this should be in the SH tree, but I have merged your fix
> to the pinctrl tree and it should be in -next, does it fix the problem?
> 
> Mainly asking because once Greg ACKs that patch I want to
> put it into the pinctrl tree...

I want to see the updated one with all of the fixes before I ack
anything.

thanks,

greg k-h
