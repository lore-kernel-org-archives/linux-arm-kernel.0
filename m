From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 12:28:52 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220111913.GZ21483@n2100.arm.linux.org.uk>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
Message-ID: <20140220112852.GM11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:19:14AM +0000, Russell King - ARM Linux wrote:
> > We have also talked about putting the SOC version and revision into
> > /proc/cpuinfo, in the Revision field. However this has not happened
> > yet.
> 
> NAK.
> 
> What's wrong with the soc subsystem (drivers/base/soc.c).  This provides
> a way to export SoC through standardised interfaces.

Hi Russell

Thanks for the tip. We will do this.

       Andrew
