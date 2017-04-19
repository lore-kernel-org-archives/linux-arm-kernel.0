From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 19 Apr 2017 11:55:12 +0200
Subject: [PATCH] ARM: dts: rockchip: reuse firefly dtsi
In-Reply-To: <CAJrj+DPjNnk9n5k4DoxJ0Focm0DOz6362PYtVRZTEkaUFKYX0g@mail.gmail.com>
References: <20170418121527.3155-1-eddie.cai.linux@gmail.com>
 <746291609.ssvjv54Vin@phil>
 <CAJrj+DPjNnk9n5k4DoxJ0Focm0DOz6362PYtVRZTEkaUFKYX0g@mail.gmail.com>
Message-ID: <1534547.uoxyx99BdA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

Am Mittwoch, 19. April 2017, 08:42:09 CEST schrieb Eddie Cai:
> 2017-04-19 6:20 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> > Hi Eddie,
> >
> > Am Dienstag, 18. April 2017, 20:15:27 CEST schrieb Eddie Cai:
> >> firefly reload is very similar with firefly board, so reuse firefly dtsi
> >>
> >> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 310 ------------------
> >>  arch/arm/boot/dts/rk3288-firefly-reload.dts       | 368 ++--------------------
> >
> > I would disagree and remember having a similar discussion when the reload-
> > support was initially submitted. Please keep in mind that the firefly-
> > reload is a som+baseboard combination, so somebody could (or maybe
> > already has) create a completely different baseboard for the som that
> > does not have any similarities with the original firefly.
> > The previous firefly being a real single board.
> >
> > We also don't combine rock2 and firefly and other boards following the
> > general rk3288 design guidelines :-) and the original firefly and reload are
> > very different boards if you look at them.
> OK, i think the real similar part is the core board and firefly. how
> about reuse the
> firefly code in the core board?

I'd really like to keep these separate.
- firefly-rk3288 is one board
- firefly-rk3288-reload is a completely different som+baseboard

That they both have the "firefly" in the name is really more based on the
company being named firefly :-) , but are not an indication that they
are similar boards.


Heiko
