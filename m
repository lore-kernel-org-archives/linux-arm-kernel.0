From: plaes@plaes.org (Priit Laes)
Date: Mon, 07 Sep 2015 10:49:02 +0300
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Add dts file for the
 pov protab2-ips9 tablet
In-Reply-To: <55ED3739.609@redhat.com>
References: <1441441319-10658-1-git-send-email-hdegoede@redhat.com>
 <20150906163023.GR31584@lukather> <55ED3739.609@redhat.com>
Message-ID: <1441612142.14422.34.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-07 at 09:05 +0200, Hans de Goede wrote:
> Hi,
> 
> On 06-09-15 18:30, Maxime Ripard wrote:
> > On Sat, Sep 05, 2015 at 10:21:59AM +0200, Hans de Goede wrote:
> > > The Point of View protab2-ips9 is a tablet with a 9" ips 1024x768
> > > lcd screen,
> > > microsd slot, headphones, mini hdmi, mini usb b and power barrel
> > > connectors.
> > > 
> > > It uses a rtl8188cus usb wifi chip and a RDA 5875Y bluetooth chip
> > > attached
> > > to uart2. It has a bma250 accelerometer attached to i2c1 addr
> > > 0x18.
> > > 

[...]
> > 
> > What is connected on i2c1 ? Just the camera sensor? or it has some
> > other devices there?
> 
> The bma250 accelerometer sits there, and the kernel already has a
> driver
> for it. That driver needs to have devicetree binding support added,
> and
> then we should be able to use the accelerometer.

bma250 already has devicetree support. It is used in Gemei G9 tablet
(sun4i-gemei-g9.dts).

P?ikest,
Priit :)
