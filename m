From: alex.aring@gmail.com (Alexander Aring)
Date: Thu, 5 Nov 2015 15:12:36 +0100
Subject: [RFCv2 2/2] rpi: add support to enable usb power domain
In-Reply-To: <20151105133510.GA12530@rob-hp-laptop>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
 <20151105133510.GA12530@rob-hp-laptop>
Message-ID: <20151105141231.GA599@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 05, 2015 at 07:35:10AM -0600, Rob Herring wrote:
> On Tue, Nov 03, 2015 at 11:45:11PM +0100, Alexander Aring wrote:
...
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> > new file mode 100644
> > index 0000000..c3abc24
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> > @@ -0,0 +1,25 @@
> > +Raspberry Pi power domain driver
> > +
> > +Required properties:
> > +
> > +- compatible:		Should be "raspberrypi,bcm2835-power".
> 
> These are board or chip level power domains? If the latter, the vendor 
> should not be raspberrypi, but Broadcom. If the former, then it should 
> describe the board rather than the chip.
> 

the access to the power domains is provided by the firmware. The
firmware is RPi specific. On an other bcm2835 with another firmware it
would be working complete different.

Everything which is accessable over the firmware is RPi specific.

- Alex
