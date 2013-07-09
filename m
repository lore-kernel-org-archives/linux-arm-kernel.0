From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jul 2013 10:29:17 +0100
Subject: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
 <20130708150721.GK27646@sirena.org.uk>
 <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
Message-ID: <20130709092917.GO27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 10:19:45AM +0200, Richard Genoud wrote:
> 2013/7/8 Mark Brown <broonie@kernel.org>:

> > The obvious question here is of course if we can use the same driver for
> > both of them.

> I haven't got a g20 to test that, but that's the goal.

I think I do somewhere.

> For now, g20 is still non-DT, so I think it's best to have a DT-only
> driver like this one for the 9x5 family (9g15, 9g25, 9x25, 9g35,
> 9x25).
> When the g20 will move to DT completely, we can drop sam9g20_wm8731.c
> and adjust sam9x5_wm8731.c (mainly master clock and widgets it seems)
> By the way, maybe g45 could use that also (and SAMA5 ?)

If this is the goal then this driver needs a more generic name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/c646adba/attachment.sig>
