From: antony@phenome.org (Antony Antony)
Date: Tue, 29 Aug 2017 23:51:12 +0200
Subject: [PATCH v2] arm64: allwinner: h5: add support for NanoPi NEO Plus 2
In-Reply-To: <BF2F26DC-7014-4AF6-9C02-D1038A0FDA38@aosc.io>
References: <20170824231716.2623-1-antony@phenome.org>
 <20170825103242.5665-1-antony@phenome.org>
 <CAEKpxBkUKGUQR2Vh1+Ci4wbB-+x48nRjLmWME2EUECCHuuwsmQ@mail.gmail.com>
 <20170828121644.p7mknytubsajzctg@AntonyAntony.local>
 <BF2F26DC-7014-4AF6-9C02-D1038A0FDA38@aosc.io>
Message-ID: <20170829215112.4p34hryd7kmhhr6w@AntonyAntony.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, Aug 28, 2017 at 08:18:58PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?8?28? GMT+08:00 ??8:16:44, Antony Antony <antony@phenome.org> ??:
> >On Fri, Aug 25, 2017 at 03:28:41PM +0200, Code Kipper wrote:
> >> On 25 August 2017 at 12:32, Antony Antony <antony@phenome.org> wrote:
> >
> >> > +
> >> > +       brcmf: bcrmf at 1 {
> >> > +               reg = <1>;
> >> > +               compatible = "brcm,bcm4329-fmac";
> >> > +       };
> >> Incorrect wifi chip - just deliver what you've tested.
> 
> Nope, this compatible is required by the dt binding, see the
> binding document or other DTs with brcmfmac SDIO.

Icenowy,

Thanks for pointing out brcm,bcm43430-fmac is missing in Documenation.
I just send a patch to wireless brcmfmac maintainers. 

https://patchwork.kernel.org/patch/9928387/

Would this work?

> Please complain to brcmfmac maintainers.

Lets see how it shakes out. 

regards,
-antony
