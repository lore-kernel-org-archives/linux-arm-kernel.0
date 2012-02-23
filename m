From: sr@denx.de (Stefan Roese)
Date: Thu, 23 Feb 2012 13:01:39 +0100
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <4F462444.8060406@st.com>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <20120223111906.GS22562@n2100.arm.linux.org.uk> <4F462444.8060406@st.com>
Message-ID: <201202231301.39345.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On Thursday 23 February 2012 12:34:28 Pratyush Anand wrote:
> >> Actually, existing drivers are using out_be32(), etc in their
> >> implementation. What do you suggest in order to use these drivers for
> >> SPEAr/ARM.
> > 
> > Which drivers?
> > .
> 
> We have used these macros in dwc_otg driver, which is still to be added
> in the main line , but is under discussion.
> 
> http://comments.gmane.org/gmane.linux.usb.general/53348

Did you notice this recent thread on the USB devel list?

http://www.spinics.net/lists/linux-usb/msg58420.html

I just wanted to make sure, that you don't continue working on this big and 
ugly dwc_otg driver (yes, I worked on it as well), when it has small to zero 
chances for upstreaming. Better to consolidate all efforts on this "smaller" 
driver with the other SoC vendors (Samsung etc).

Thanks,
Stefan
