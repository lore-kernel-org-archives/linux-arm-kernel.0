From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jun 2016 09:29:42 +0200
Subject: [PATCH 20/22] gpio: clps711x: Remove board support
In-Reply-To: <CACRpkdZcNoXbgRfM=eFkXtOeHnfAdJAY7G-gc5JrQJeaVM_y6g@mail.gmail.com>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-21-git-send-email-shc_work@mail.ru>
 <CACRpkdZcNoXbgRfM=eFkXtOeHnfAdJAY7G-gc5JrQJeaVM_y6g@mail.gmail.com>
Message-ID: <6542551.A6t11aBrTr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 8, 2016 10:51:14 AM CEST Linus Walleij wrote:
> On Sat, Jun 4, 2016 at 9:10 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> > Since board support for the CLPS711X platform was removed,
> > remove the board support from the driver.
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Patch applied to the GPIO tree.
> 
> BTW I hope it's OK to take these three patches and apply
> separately, else tell me and I'll take them out again and you
> can have my Acked-by if you want to take them through ARM
> SoC instead.

I think that's fine. We will have a short time span during the
merge window in which not everything works with either DT or
the board files, but as Alexander explained, this hardware
is now obsolete, so I think that is ok in this instance,
and it makes the migration easier.

	Arnd
