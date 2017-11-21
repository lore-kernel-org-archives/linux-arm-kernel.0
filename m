From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 21 Nov 2017 21:28:04 +0100 (CET)
Subject: [PATCH RFC] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <20171121195851.x5vv3qrlfx2t2xb2@camel2.lan>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
 <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
 <1656114989.298026.1511209469286@email.1und1.de>
 <20171121195851.x5vv3qrlfx2t2xb2@camel2.lan>
Message-ID: <1845541920.312172.1511296084835@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hias,

> Matthias Reichl <hias@horus.com> hat am 21. November 2017 um 20:58 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Mon, Nov 20, 2017 at 09:24:29PM +0100, Stefan Wahren wrote:
> > > Matthias Reichl <hias@horus.com> hat am 20. November 2017 um 14:18 geschrieben:
> > > 
> > > While testing with a simple card DT overlay I noticed another
> > > issue: the i2s node is missing the #sound-dai-cells property
> > > and simple card refuses to load because of that:
> > > 
> > > [    0.956912] OF: /sound/simple-audio-card,cpu: could not get #sound-dai-cells for /soc/i2s at 7e203000
> > 
> > This should be a separate patch. Could you please send a proper one after this has been applied?
> 
> Sure, will do that.

Great. Can i assume your Tested-by for my patch?
