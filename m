From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 9 Feb 2015 15:13:43 +0100
Subject: [PATCHv6 0/2] Driver for TI tlc591xx 8/16 Channel i2c LED driver
In-Reply-To: <54D89F0D.9050506@ti.com>
References: <1422367161-16487-1-git-send-email-andrew@lunn.ch>
 <20150206031048.GA9614@lunn.ch> <54D89F0D.9050506@ti.com>
Message-ID: <20150209141343.GA5631@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 01:50:37PM +0200, Tomi Valkeinen wrote:
> On 06/02/15 05:10, Andrew Lunn wrote:
> > On Tue, Jan 27, 2015 at 02:59:19PM +0100, Andrew Lunn wrote:
> >> This patchset is a driver for the TI tlc59116 16 Channel i2c LED
> >> driver and tlc59108 8 Channel i2c LED driver. This driver is used on
> >> the Belkin WRT1900AC access point and the C code is derived from code
> >> Belkin contributed to OpenWRT.  However it has been extensively
> >> re-written, and a device tree binding added to replace platform data.
> > 
> > Hi Bryan
> > 
> > Do you have any further comments on this driver? Are you likely to
> > queue it up for the next merge window?
> 
> Hi Andrew,
> 
> You didn't comment anything on my and Peter's questions on v5 thread
> about this being a PWM driver.

Hi Tomi

I don't comment, because it is not our decision to make any more. We
have been around this argument many times, so we are not going to
resolve it. The LED and PWM maintainers need to decide, not us.

	Andrew
