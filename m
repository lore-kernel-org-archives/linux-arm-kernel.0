From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 24 Mar 2017 08:12:07 +0100
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
In-Reply-To: <58D4BD40.5090900@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <58D34208.6090509@rock-chips.com> <58D4BD40.5090900@rock-chips.com>
Message-ID: <3271639.DkaRJdVeCG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 24. M?rz 2017, 14:31:28 CET schrieb ??:
> Hi, Heiko:
> 
> ? 2017?03?23? 11:33, ?? ??:
> > Hi, Heiko
> > 
> > ? 2017?03?21? 16:55, Heiko St?bner ??:
> >> Hi,
> >> 
> >> Am Donnerstag, 16. M?rz 2017, 21:17:22 CET schrieb cl at rock-chips.com:
> >>> +        assigned-clock-parents =
> >>> +            <&cru HDMIPHY>, <&cru PLL_APLL>,
> >>> +            <&cru PLL_GPLL>, <&xin24m>,
> >>> +            <&xin24m>, <&xin24m>;
> >>> +        assigned-clock-rates =
> >>> +            <0>, <61440000>,
> >>> +            <0>, <24000000>,
> >>> +            <24000000>, <24000000>,
> >>> +            <15000000>, <15000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <50000000>, <100000000>,
> >>> +            <100000000>, <100000000>,
> >>> +            <50000000>, <50000000>,
> >>> +            <50000000>, <50000000>,
> >>> +            <24000000>, <600000000>,
> >>> +            <491520000>, <1200000000>,
> >>> +            <150000000>, <75000000>,
> >>> +            <75000000>, <150000000>,
> >>> +            <75000000>, <75000000>,
> >>> +            <300000000>, <100000000>,
> >>> +            <300000000>, <200000000>,
> >>> +            <400000000>, <500000000>,
> >>> +            <200000000>, <300000000>,
> >>> +            <300000000>, <250000000>,
> >>> +            <200000000>, <100000000>,
> >>> +            <24000000>, <100000000>,
> >>> +            <150000000>, <50000000>,
> >>> +            <32768>, <32768>;
> >>> +    };
> >>> +
> >>> +    gmac2io: eth at ff540000 {
> >> 
> >> phandle should be gmac instead?
> >> Node name, ethernet at ff540000
> > 
> > RK3328 have another gmac channel with PHY in the soc, so gmac2io mean
> > the channel with the PHY outside, and it is also called gmac2io in the
> > TRM.
> 
> So we remain gmac2io, or you have other idea?

No, that is ok in that case.

Heiko
