From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 6 May 2010 05:23:05 +0300
Subject: [PATCH] fec.c: Fix memory corruption in fec_set_mac_address.
In-Reply-To: <20100505201514.GA25037@pengutronix.de>
References: <4BDDE158.1050404@vmlinux.org>
	<20100505201514.GA25037@pengutronix.de>
Message-ID: <20100506022305.GB2388@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe, Mattias,

On Wed, May 05, 2010 at 10:15:14PM +0200, Uwe Kleine-K?nig wrote:
> On Sun, May 02, 2010 at 10:32:24PM +0200, Mattias Walstrom wrote:
> > Fix memory corruption that may result in kernel panics.
> > 
> > Signed-off-by: Mattias Walstr?m <mattias@vmlinux.org>
> > 
> You might want to send this to netdev and make sure to keep the diffstat
> out of the changelog.

This is already applied upstream (7cff0943a).

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
