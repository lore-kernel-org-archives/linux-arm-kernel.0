From: mporter@konsulko.com (Matt Porter)
Date: Mon, 2 Mar 2015 14:21:16 -0500
Subject: [PATCH] ARM: dts: hummingboard: enable pcf8523 rtc for i2eX
In-Reply-To: <20150302190616.GS8656@n2100.arm.linux.org.uk>
References: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
 <20150302190204.GR8656@n2100.arm.linux.org.uk>
 <20150302190616.GS8656@n2100.arm.linux.org.uk>
Message-ID: <20150302192116.GA30263@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[added Rabeeh]

On Mon, Mar 02, 2015 at 07:06:16PM +0000, Russell King wrote:
> On Mon, Mar 02, 2015 at 07:02:04PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 02, 2015 at 01:50:06PM -0500, Matt Porter wrote:
> > > The PCF8523 RTC is populated on the i2eX boards so
> > > enable the i2c1 controller and enable the device on
> > > that bus.
> > 
> > Hmm, I wonder where my update patches went... oh, they're still sitting
> > in my excessive backlog of patches in my tree as part of my "sgtl5000
> > hacks" patch...
> 
> Also note that before we accept patches to the SolidRun stuff, we should
> first re-license the file as GPLv2/X11.

Hi Russell,

Given that there's no license information at all on any of these three
dts files I think that's a good idea. I just realized I didn't copy
Rabeeh on this and he's apparently the original submitter based on
your work. Ideally Rabeeh should send a license update but I could do
so if you'd like and gather some acks.

OTOH, did you already have a license update somewhere in your backlog
of patches?

-Matt
