From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 14 Sep 2015 10:47:19 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: Add dtb for the Radxa Rock 2
 Square board
In-Reply-To: <1442217958.8778.103.camel@collabora.co.uk>
References: <1442011005-4828-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CABxcv==JF5QKG8qmrRRUSi4j0=7guQQJTzVzR2bgSxdtUDBv7Q@mail.gmail.com>
 <1442217958.8778.103.camel@collabora.co.uk>
Message-ID: <7783425.5jykIre40o@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. September 2015, 10:05:58 schrieb Sjoerd Simons:
> Hey Javier,
> 
> On Mon, 2015-09-14 at 09:50 +0200, Javier Martinez Canillas wrote:
> > Hello Sjoerd,
> > 
> > On Mon, Sep 14, 2015 at 9:30 AM, Sjoerd Simons
> > 
> > <sjoerd.simons@collabora.co.uk> wrote:
> > > For the first patch i do prefer to keep them on so we can have get
> > > some
> > > more testing  with this board before fine-tuning those things
> > > (fwiw,
> > 
> > Ok.
> > 
> > > the rockchip evb board and others with essentially the same pmic
> > > setup
> > > all also have them always-on)
> > 
> > Yes but I believe that's because it was easier and there are
> > regulators on these boards that don't need to be always-on as well.
> 
> Yes what i was trying to say is that it's not an uncommon to keep these
> on for convenience while fine-tuning the device-tree setups ;)

Also, a lot of drivers do not yet do proper regulator handling (our drm/kms 
driver as a prime example), so the number of regulators able to being actually 
turned off is quite slim.

So I guess I'm ok, with handling these once driver components can actually do 
something with their supplies :-) .


Heiko
