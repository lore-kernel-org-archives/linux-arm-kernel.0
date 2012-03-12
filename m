From: stigge@antcom.de (Roland Stigge)
Date: Mon, 12 Mar 2012 22:52:47 +0100
Subject: [PATCH v7 0/4] USB: OHCI-HCD: Support for LPC32xx
In-Reply-To: <20120312190241.GA28087@pengutronix.de>
References: <1331463219-23293-1-git-send-email-stigge@antcom.de>
 <20120312190241.GA28087@pengutronix.de>
Message-ID: <4F5E702F.8040703@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 12/03/12 20:02, Wolfram Sang wrote:
> On Sun, Mar 11, 2012 at 11:53:35AM +0100, Roland Stigge wrote:
>> These patches add support for the LPC32xx to the ohci-pnx4008
>> driver and make the driver use smbus functions.
> 
> Do you have a branch ready to test (USB driver fixes + mach
> additions)? I'd like to test but I get lots of conflicts when
> adding the mach related stuff. I probably have a different base?

I just pushed into the following branches at
git://git.antcom.de/linux-2.6.git :

* lpc32xx/usb - The ohci-pnx driver as submitted on the USB mailing list
* lpc32xx/eth - The ethernet driver as submitted on the ethernet
                mailing list
* lpc32xx/baseline - Patches on top of v3.3-rc7 which have already been
                     accepted into the various subsystem maintainer's
                     repos. This is the baseline on top of which the
                     next two branches are forked from
* lpc32xx/mach-lpc32xx-usb - Mach specific USB part
* lpc32xx/mach-lpc32xx-eth - Mach specific ethernet part

Roland
