From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 17 Jan 2013 13:57:02 +0100
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <20130117105104.GN10814@arwen.pp.htv.fi>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
 <20130110133818.GA22710@balto.lan>
 <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
 <20130117105104.GN10814@arwen.pp.htv.fi>
Message-ID: <20130117125702.GA5007@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:51:04PM +0200, Felipe Balbi wrote:
> > > Thanks for the ACK.  This bug was here unnoticed since 3.6 merge window,
> > 
> > Then it should have Cc: stable at kernel.org..
> 
> just added to my tree.

Hi Felipe, thanks for adding the stable tag to the patch, but I actually
made a bit of confusion with the versions, so I double checked and it
turns out this is really needed on v3.7 stable, not v3.6.

Will you be so kind to remove v3.6 from the stable tag from this
patch?

Thanks and sorry for the added noise!
Fabio

-- 
Fabio Baltieri
