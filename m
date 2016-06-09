From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Jun 2016 15:50:38 +0100
Subject: [PATCH 4/4] mfd: db8500 stop passing around platform data
In-Reply-To: <3648943.90TpD9e9VC@wuerfel>
References: <1462889050-2818609-1-git-send-email-arnd@arndb.de>
 <CACRpkdZdR1rESjgD-p=79Jk3sp+Xi4ER1vYOsKcr6aAfHztpiw@mail.gmail.com>
 <3648943.90TpD9e9VC@wuerfel>
Message-ID: <20160609145038.GM2385@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jun 2016, Arnd Bergmann wrote:

> On Wednesday, June 8, 2016 1:37:12 PM CEST Linus Walleij wrote:
> > On Tue, May 10, 2016 at 4:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > Except for the constant DB8500_PRCMU_FW_VERSION_OFFSET number, nothing
> > > is ever passed through the platform data and used in a driver, so we
> > > can simply stop passing it around.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Do you think it's relevant for Lee to take this or do you want to
> > have it in ARM SoC together with the other cleanups (that I
> > haven't had time to look at...)?
> > 
> > In the latter case I need an ACK from Lee to apply it for a pull
> > request to ARM SoC.
> > 
> > The functionality it pertains to is out-of-tree but if we want to
> > reintroduce it, it should happen through DT anyway.
> 
> I think most of the changes are in mfd, so it would be appropriate
> for Lee to take them all, but I could also put them into arm-soc
> if he prefers.

Up to you.  If you want a pull-request, I can provide you with one.
If you are happy to 'risk it', I'm good with that too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
