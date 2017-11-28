From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Nov 2017 10:45:03 +0000
Subject: [PATCH 03/13] ARM: dts: imx6qdl: SolidRun: move microsom
 includes into .dts
In-Reply-To: <CALHpu36Kjy4SSn1m8ZOYwEr+9u67dobfNHiOX6s75UFGVm3atw@mail.gmail.com>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
 <E1eJMdo-0002qf-2D@rmk-PC.armlinux.org.uk>
 <CALHpu36Kjy4SSn1m8ZOYwEr+9u67dobfNHiOX6s75UFGVm3atw@mail.gmail.com>
Message-ID: <20171128104503.GU31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 05:46:07AM +0100, Jon Nettleton wrote:
> On Mon, Nov 27, 2017 at 5:52 PM, Russell King <rmk+kernel@armlinux.org.uk>
> wrote:
> 
> > Move the microsom includes into the .dts files so different options can
> > be accomodated at the lowest level.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Since we are going through and adding the som dtsi include to all the
> device-tree files, would it make sense to rename the microsom.dtsi at this
> point in time?  Perhaps something like imx6qdl-sr-microsom.dtsi?

Shawn,

Having discussed with Jon this morning, we've decided that as 
"imx6qdl-microsom.dtsi" is too generic, we'll to rename that file as
"imx6qdl-sr-som.dtsi" instead.  New patch series on its way.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
