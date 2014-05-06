From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 May 2014 13:53:51 -0500
Subject: [PATCH 0/6] ARM: sunxi: Machine code cleanup
In-Reply-To: <20140505155113.GB25199@roeck-us.net>
References: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140505155113.GB25199@roeck-us.net>
Message-ID: <20140506185351.GK9464@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 08:51:13AM -0700, Guenter Roeck wrote:
> On Sun, May 04, 2014 at 10:07:58PM -0500, Maxime Ripard wrote:
> > Hi,
> > 
> > This serie moves the restart code out of the mach-sunxi directory to
> > either the watchdog driver or to a new driver in drivers/power/reset.
> > 
> > Since the reset code was pretty much all the code left in the
> > mach-sunxi directory for all the SoCs but the A31, the only thing left
> > into mach-sunxi are empty machine definition.
> > 
> Hi Maxime,
> 
> what changed in this version of the series compared to the previous
> version ? Is it just the different directory for the reset driver ?

Gosh, I was really too tired to send patches.

I'll resend.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/bf7812c8/attachment.sig>
