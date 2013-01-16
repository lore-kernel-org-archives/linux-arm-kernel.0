From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 10:49:05 -0700
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <CACRpkdbFH6RCEEnXO=A9FVa0B5rtE9RkjXz9Hhy+w7NvwcBCgg@mail.gmail.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
 <CACRpkdZ0b=ZohgaBH3qPH_O5TiWmXJXs6872D+YPVA9g4BssYg@mail.gmail.com>
 <9702060.jEbHySsCv0@avalon>
 <CACRpkdbFH6RCEEnXO=A9FVa0B5rtE9RkjXz9Hhy+w7NvwcBCgg@mail.gmail.com>
Message-ID: <50F6E811.2040606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 01:45 PM, Linus Walleij wrote:
> On Fri, Jan 11, 2013 at 9:36 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> 
>> I've sent several patch series for the SH PFC (Pin Function Controller) to the
>> linux-sh mailing list. One of the series included pinctrl core patches for
>> easier testing, but I made it clear that they should *not* be pushed to
>> mainline through the SH tree.
> 
> No big deal, what fun is linux-next if we don't break it ;-)

Hmm. It's causing a lot of engineers here a lot of trouble, since they
all see linux-next won't boot, and haven't been paying enough attention
to know which commit to revert:-(. Lots of lost productivity:-(

Simon, the offending commit:

6d3ef6b drivers/pinctrl: grab default handles from device core

is still in next-20130116. Can you please remove it?

Or does it make sense for Stephen Rothwell to revert it when building
linux-next?
