From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 12:51:04 +0200
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
 <20130110133818.GA22710@balto.lan>
 <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
Message-ID: <20130117105104.GN10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 11:46:30AM +0100, Linus Walleij wrote:
> On Thu, Jan 10, 2013 at 2:38 PM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> > On Thu, Jan 10, 2013 at 12:23:32PM +0100, Linus Walleij wrote:
> >> On Mon, Jan 7, 2013 at 5:47 PM, Fabio Baltieri
> >> <fabio.baltieri@linaro.org> wrote:
> >>
> >> > This patch converts the module to use clk_prepare_enable and
> >> > clk_disable_unprepare variants as required by common clock framework.
> >> >
> >> > Without this the system crash during probe function.
> >> >
> >> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> >>
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks for the ACK.  This bug was here unnoticed since 3.6 merge window,
> 
> Then it should have Cc: stable at kernel.org..

just added to my tree.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/c7c4d190/attachment.sig>
