From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:44:40 +0200
Subject: [GIT PULL] move Versatile flash protection to the device tree
In-Reply-To: <20160404163626.GA30894@localhost>
References: <CACRpkdZxrhkL7a6DG3frKeR+=xF6X4nczepAbqj1PGDs3VsmMQ@mail.gmail.com>
 <20160404163626.GA30894@localhost>
Message-ID: <6943273.jykU37cR72@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 April 2016 09:36:26 Brian Norris wrote:
> 
> On Mon, Apr 04, 2016 at 10:45:48AM +0200, Linus Walleij wrote:
> > Hi ARM SoC folks,
> > 
> > now I'm tired of waiting for the MTD maintainers' word on this patch
> > series. I sent a question about this approach on february 13:
> > http://marc.info/?l=linux-arm-kernel&m=145537026603174&w=2
> > 
> > With subsequent pings on feb 22, mar 5, mar 31, and the cleanup
> > missing the merge window.
> > 
> > As you can see the flash protection patch also caters for the
> > RealView flash protection bits.
> > 
> > Please pull this into the ARM SoC tree for testing in linux-next
> > for the v4.7 series. If the MTD people appear again and have issues
> > you can always drop the branch.
> > 

> > 
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> 

Merged into next/drivers, thanks!

	Arnd
