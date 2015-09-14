From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 14 Sep 2015 10:05:58 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <CABxcv==JF5QKG8qmrRRUSi4j0=7guQQJTzVzR2bgSxdtUDBv7Q@mail.gmail.com>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1442011005-4828-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <CABxcv=nRjge1qMeoXt6U6McKbv30oYUhh9C417mX0B=bt9Jg-g@mail.gmail.com>
 <1442215849.8778.101.camel@collabora.co.uk>
 <CABxcv==JF5QKG8qmrRRUSi4j0=7guQQJTzVzR2bgSxdtUDBv7Q@mail.gmail.com>
Message-ID: <1442217958.8778.103.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Javier,

On Mon, 2015-09-14 at 09:50 +0200, Javier Martinez Canillas wrote:
> Hello Sjoerd,
> 
> On Mon, Sep 14, 2015 at 9:30 AM, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:

> > For the first patch i do prefer to keep them on so we can have get
> > some
> > more testing  with this board before fine-tuning those things
> > (fwiw,
> 
> Ok.
> 
> > the rockchip evb board and others with essentially the same pmic
> > setup
> > all also have them always-on)
> 
> Yes but I believe that's because it was easier and there are
> regulators on these boards that don't need to be always-on as well.

Yes what i was trying to say is that it's not an uncommon to keep these
on for convenience while fine-tuning the device-tree setups ;)

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
