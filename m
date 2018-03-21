From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Mar 2018 09:54:36 +0100
Subject: [PATCH 42/52] ARM: dts: r7s72100: add USB device to device tree
In-Reply-To: <TY1PR01MB1562CEB3464308DFDBA00C6D8AAB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
 <faa6c0071114fd433e83dddd3a42fba547ca9a67.1521208546.git.horms+renesas@verge.net.au>
 <TY1PR01MB1562ED183D137FA48FCBC7DB8AD70@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdXdvH4Ywj_3rr8MSi-9AKN=WoDtdwHQdAJF=w0RJ8maaA@mail.gmail.com>
 <TY1PR01MB1562CEB3464308DFDBA00C6D8AAB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <20180321085435.3kvleabhysexdbit@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 11:20:39AM +0000, Chris Brandt wrote:
> Hi Geert,
> 
> On Tuesday, March 20, 2018, Geert Uytterhoeven wrote:
> > > At one point Greg applied it, then reverted it (as requested by Geert),
> > > but then somehow it still went in.
> > 
> > It's not present in upstream:
> > 
> > $ git grep usbhs0 v4.16-rc6 -- arch/arm/boot/dts/r7s72100.dtsi
> > $
> 
> 
> Yes, you're right. It's not there.
> 
> So somehow I found the commit...but in the end it's not in upstream.
> 
> I'm sorry Simon, but that patch really does belong in there.
> 
> Sorry for the trouble :(

No problem. I'd rather not respin this pull request for a second time so
lets leave the patch where it now is, queued up in the renesas tree for
v4.18.
