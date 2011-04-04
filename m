From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 13:59:09 +0100
Subject: [PATCH 2/3] Use gpio_set_value_cansleep() in corgi_lcd.c
In-Reply-To: <20110404124926.GA22480@n2100.arm.linux.org.uk>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
	<1301708597-7413-2-git-send-email-marek.vasut@gmail.com>
	<BANLkTimtLsF_fQQbfxRQZ6ToBWj5HvGm6A@mail.gmail.com>
	<20110404120633.GB26494@opensource.wolfsonmicro.com>
	<BANLkTikqZ3ptO2iwbFy+9GQBt4nAj+3y8g@mail.gmail.com>
	<1301921057.2219.2.camel@konomi>
	<20110404124926.GA22480@n2100.arm.linux.org.uk>
Message-ID: <20110404125909.GB22480@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 01:49:26PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2011 at 02:44:17PM +0200, Marek Vasut wrote:
> > > On Mon, Apr 4, 2011 at 8:06 PM, Mark Brown
> > > <broonie@opensource.wolfsonmicro.com> wrote:
> > > > On Mon, Apr 04, 2011 at 06:45:46PM +0800, Eric Miao wrote:
> > > > > Personally, I don't quite like the idea of an explicit _cansleep()
> > > > > version, which is just confusing. A programmer shouldn't be aware of
> > > > > which version to use.
> > > > 
> > > > When working in interrupt context you need to pay attention to this
> > > > stuff; personally I'd prefer an explict IRQ safe version but YMMV. ?The
> > > > only use the code makes of this is to generate warnings to make
> > > > problems easier to diagnose.
> > > > 
> > > > > David, you have any justification?
> > > > 
> > > > Sadly David passed away recently.
> > > > 
> > > 
> > > What????!!!!????? I didn't know that.
> > 
> > Me neither. I'm shocked. What happened?
> 
> >From what I can tell, so far it's been passed around in private mail
> only, and so people are hearing about it 3rd, 4th or more hand - which
> really isn't the way to go about giving this news.
> 
> So, I'm not going to pass on the details which I've heard, instead
> I'd suggest people wait for (or try to find) an official announcement.

Additionally, I'd like to say that I've requested from the person I heard
the news from the details for sending condolences, but so far I'm none
the wiser.
