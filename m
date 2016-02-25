From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Thu, 25 Feb 2016 11:50:23 -0500
Subject: [PATCH v3 6/6] arm: lpc32xx: phy3250 remove restart hook
In-Reply-To: <2913764.6ZXbKHTUYJ@wuerfel>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com>
 <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
 <2913764.6ZXbKHTUYJ@wuerfel>
Message-ID: <1456419023.25197.16.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 2016-02-24 at 22:20 +0100, Arnd Bergmann wrote:
> On Wednesday 24 February 2016 12:46:58 Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> > 
> > Remove the restart hook assignment from phy3250;
> > this functionality is now managed by
> > the pnx4008 watchdog driver.
> > 
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Note:
> > This patch was generated with the option "--unified=2" to ensure
> > it can be apply before or after the following git pull request
> > for the LPC32xx platform:
> > - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477137
> > - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477138
> 
> This patch really needs to come before patch 5 in the series, or
> you could combine the two into a single patch.
> 
There is more change coming to the LPC32xx platform that will 
modify "phy3250.c" (LPC32xx irqchip driver).

You can refer to the following link for details:
http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683

I prefer to keep the change for "phy3250.c" in a separate patch.
I will submit a new revision later today to reverse patch order.


Sylvain Lemieux

> 	Arnd
