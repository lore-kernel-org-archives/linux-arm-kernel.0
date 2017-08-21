From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 21 Aug 2017 10:33:57 +0200
Subject: [PATCH  2/3] ARM: dts: iwg20m: Enable SDHI0 controller
In-Reply-To: <KL1PR06MB1702AC0B4C40F48A80505B74B8870@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
 <1502711389-16040-3-git-send-email-biju.das@bp.renesas.com>
 <20170821082842.GB2418@katana>
 <KL1PR06MB1702AC0B4C40F48A80505B74B8870@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <20170821083357.GC2418@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > +vmmc-supply = <&reg_3p3v>;
> > > +vqmmc-supply = <&reg_3p3v>;
> >
> > Just to make sure: No 1.8V and UHS support (SDR50/104)? Or is this to be
> > tested and added later?
> 
> Thanks. The current hardware doesn't support 1.8V switching for SDHI0. There is a plan to
> add this in future board varient, at that time we will add UHS support.

I see. Thanks for the info, patch looks good to me then:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/c0d108f9/attachment.sig>
