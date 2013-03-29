From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 29 Mar 2013 15:13:51 -0300
Subject: [PATCH] arm: mvebu: Add GPIO LEDs to Mirabox board
In-Reply-To: <alpine.DEB.2.02.1303290719570.31379@vroombuntu>
References: <1364523024-20306-1-git-send-email-ryan@presslab.us>
 <alpine.DEB.2.02.1303290719570.31379@vroombuntu>
Message-ID: <20130329181350.GB2451@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 07:24:04AM +0000, Neil Greatorex wrote:
> 
> On Thu, 28 Mar 2013, Ryan Press wrote:
> 
> > Add the three external LED definitions to the device tree file on
> > the Mirabox.
> >
> > The Mirabox user guide calls out one as a power LED, and the other
> > two are defined for WiFi, but as the current mwifiex drivers don't
> > have LED support, we make them status LEDs.
> >
> > These have been tested working by writing to the appropriate
> > /sys/class/leds trigger.
> >
> > Signed-off-by: Ryan Press <ryan@presslab.us>
> > ---
> > arch/arm/boot/dts/armada-370-mirabox.dts | 37 ++++++++++++++++++++++++++++++++
> > 1 file changed, 37 insertions(+)
> 
> Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
> 

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
