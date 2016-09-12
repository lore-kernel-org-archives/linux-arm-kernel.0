From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Sep 2016 21:15:20 +0200
Subject: [PATCH 1/3] misc: Add Aspeed BT IPMI host driver
In-Reply-To: <1ce6c4b4-5938-22fc-7467-d1efc220b772@gmail.com>
References: <1472664259-23933-1-git-send-email-clg@kaod.org>
 <c06a8afb-9143-6aef-3425-ad1e50cae35d@kaod.org>
 <1ce6c4b4-5938-22fc-7467-d1efc220b772@gmail.com>
Message-ID: <4727554.yt7pF8chOH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 1:55:40 PM CEST Corey Minyard wrote:
> On 09/02/2016 08:22 AM, C?dric Le Goater wrote:
> > Hello,
> >
> > Adding Corey in cc: . I guess I should have done that in the first place.
> 
> Yes, probably so.  I've been travelling and didn't see it on the mailing
> lists until now.
> 
> There is already a BT driver in the kernel, in drivers/char/ipmi, why
> won't that work?

The new driver is the host side (running on the BMC), the existing one
is the client (running on the PC).

	Arnd
