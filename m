From: abhijeet.tripathy@yahoo.co.in (abhijeet tripathi)
Date: Sat, 14 Nov 2009 15:33:06 +0530 (IST)
Subject: Kernel Panic while booting arm-pb1176
In-Reply-To: <20091114085236.GA19214@n2100.arm.linux.org.uk>
Message-ID: <265042.87910.qm@web7602.mail.in.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

--- On Sat, 14/11/09, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: Kernel Panic while booting arm-pb1176
> To: "abhijeet tripathi" <abhijeet.tripathy@yahoo.co.in>
> Cc: linux-arm-kernel at lists.infradead.org, "abhijeet" <abhijeet.tripathy@gmail.com>, mayur.nan at gmail.com
> Date: Saturday, 14 November, 2009, 2:22 PM
> On Sat, Nov 14, 2009 at 02:05:52PM
> +0530, abhijeet tripathi wrote:
> > I am attaching the console logs.
> 
> I think it's one for networking people.? Looks to me
> like some MDIO
> device is being registered twice.

Thanks to your pointer.

Disabling CONFIG_FIXED_PHY fixed the issue for me, you were right that MDIO was being registered twice.
 
> Be sure to send them the full kernel boot log as well.
> 

--regards,
Abhijeet


      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/
