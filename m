From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:27:03 +0200
Subject: [PATCH v4 6/6] ARM: sun8i: h3: add partial CPU thermal zone
In-Reply-To: <20170916151734.10968b7a@archlinux>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-7-icenowy@aosc.io>
 <b41a80ec-23d5-a614-f6cc-d09c5a459e03@free-electrons.com>
 <20170916151734.10968b7a@archlinux>
Message-ID: <20170918082703.riqntqilakzhirc5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sat, Sep 16, 2017 at 03:17:34PM -0700, Jonathan Cameron wrote:
> On Sat, 16 Sep 2017 12:05:49 +0200
> Quentin Schulz <quentin.schulz@free-electrons.com> wrote:
> 
> > Hi Icenowy,
> > 
> > On 14/09/2017 16:52, Icenowy Zheng wrote:
> > > Because of the restriction of the OF thermal framework, the thermal
> > > sensor will fail to probe if the thermal zone doesn't exist.
> > >   
> > 
> > Oh no, that's not good.
> > 
> > We discussed about it on IRC and I even proposed a patch for it, telling
> > you I would post it on the mailing list soon after. Of course, I forgot
> > and you definitely should have yelled at me for not doing it :)
> > 
> > I won't be able to test the patch soon. I can send it to you so that you
> > can test it and integrate it in your patch series so it won't block you.
> > Otherwise, we'll have to wait for a week or two for me to test it.
> > 
> > Thanks and sorry for forgetting to post the patch you need,
> > Quentin
> 
> Other this outstanding issue I'm happy with the series, so hopefully
> with Quentin's patch added we should be good to merge this one.

We will at least need a v5.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/c0d7e7f1/attachment.sig>
