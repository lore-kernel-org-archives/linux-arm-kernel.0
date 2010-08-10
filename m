From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 20:56:19 +0100
Subject: [PATCH]: Fix arm kconfig
In-Reply-To: <AANLkTikR-JJ9CP0eU3Lq251LPr_JRScBAih-dJdrt5fx@mail.gmail.com>
References: <AANLkTikR-JJ9CP0eU3Lq251LPr_JRScBAih-dJdrt5fx@mail.gmail.com>
Message-ID: <20100810195619.GB7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 09:42:12PM +0200, xsecute at googlemail.com wrote:
> Hi Russell,
> 
> i get an nerror if i try: make ARCH=arm CROSS_COMPILE=arm-eabi

Yes, Erik Miao reported it yesterday, and I suggested getting rid of the
paren which isn't actually required.  Unfortuantely, I'm still waiting
for that to happen... and land in the patch system.

Instead, the patch system seems to be filling with stuff for the next
merge window...
