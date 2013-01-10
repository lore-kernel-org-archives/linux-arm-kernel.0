From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 10 Jan 2013 14:38:18 +0100
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
Message-ID: <20130110133818.GA22710@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Thu, Jan 10, 2013 at 12:23:32PM +0100, Linus Walleij wrote:
> On Mon, Jan 7, 2013 at 5:47 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> 
> > This patch converts the module to use clk_prepare_enable and
> > clk_disable_unprepare variants as required by common clock framework.
> >
> > Without this the system crash during probe function.
> >
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the ACK.  This bug was here unnoticed since 3.6 merge window,
do you think it may make sense to add this driver to u8500_defconfig?  I
can send a patch if you say so...

Thanks,
Fabio

-- 
Fabio Baltieri
