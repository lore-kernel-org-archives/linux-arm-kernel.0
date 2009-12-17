From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2009 21:13:13 +0000
Subject: USB Host on a SA1111
In-Reply-To: <20091217212636.22bea701.kristoffer.ericson@gmail.com>
References: <de2dcbb80912160851g9def9d0p77e46ba0f572fea4@mail.gmail.com>
	<20091217212636.22bea701.kristoffer.ericson@gmail.com>
Message-ID: <20091217211313.GA16520@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 09:26:36PM +0100, Kristoffer Ericson wrote:
> On Wed, 16 Dec 2009 17:51:08 +0100
> Filip Zyzniewski <filip.zyzniewski@gmail.com> wrote:
> 
> > Hi,
> > 
> > I have found out a way to connect an USB receptacle to USB host pins on
> > SA1111 inside a HP Jornada 720. The modification is described at
> > http://jlime.com/mw4/index.php/Hardware_documentation_jornada700_usbhost .
> > 
> > Unfortunately it still doesn't work as expected - I have dumped some dmesgs
> > here: http://filip.math.uni.lodz.pl/jornada/usb_host/ .
> > The most interesting ones are these where kernel can retrieve proper
> > identification numbers (optical mouse, card driver). But communication fails
> > afterwards. Devices aren't usable.
> 
> Russell you got any clues on this? From my point of view it really should
> just work. But Ive never done this myself.

I've never really been that much involved with USB stuff, so can't really
comment.
