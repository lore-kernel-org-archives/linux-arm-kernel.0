From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Jun 2013 11:27:23 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <1733666.lHUBcfUXq9@flatron>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron>
Message-ID: <20130606112723.71ddd70c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tomasz Figa,

On Thu, 06 Jun 2013 02:01:14 +0200, Tomasz Figa wrote:

> I don't see any other solution here than moving all the Allwinner
> code to DT (as it has been suggested in this thread several times
> already), as this is the only hardware description method supported
> by ARM Linux.

Have you noticed that it is already the case in mainline? My colleague
Maxime Ripard (Cc'ed) is the maintainer of the mainline Allwinner sunxi
effort. It already supports a number of boards, has a pinctrl driver, a
GPIO driver, serial port is working, network is working, I2C is
working.

All in mainline, completely Device Tree based.

So isn't this entire discussion completely moot? The mainline support
for sunxi has already started since 6 months or so, and has been Device
Tree based from day one.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
