From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jan 2018 15:43:34 +0100
Subject: [RFC PATCH 0/9] initial support for "suniv" Allwinner new ARM9 SoC
In-Reply-To: <2A78FC75-61C0-4317-A7A1-6E1E42098C07@aosc.io>
References: <20180119231735.61504-1-icenowy@aosc.io>
 <20180122121435.bpayxk4uzfqbhqse@flea.lan>
 <14593819.uISRktVE4V@ice-x220i>
 <20180125153520.lxcfvh3yvi36uiux@flea.lan>
 <2A78FC75-61C0-4317-A7A1-6E1E42098C07@aosc.io>
Message-ID: <20180126144334.27hengoucfipdsdj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 11:38:04PM +0800, Icenowy Zheng wrote:
> >On Wed, Jan 24, 2018 at 09:10:34PM +0800, Icenowy Zheng wrote:
> >> ? 2018?1?22???? CST ??8:14:35?Maxime Ripard ???
> >> > On Sat, Jan 20, 2018 at 07:17:26AM +0800, Icenowy Zheng wrote:
> >> > > This is the RFC initial patchset for the "new" Allwinner SUNIV
> >ARM9 SoC.
> >> > > 
> >> > > The same die is packaged differently, come with different
> >co-packaged
> >> > > DRAM or shipped with different SDK; and then made many model
> >names: F23,
> >> > > F25, F1C100A, F1C100S, F1C200S, F1C500, F1C600, R6, etc. These
> >SoCs all
> >> > > share a common feature set and are packaged similarly (eLQFP128
> >for SoCs
> >> > > without co-packaged DRAM, QFN88 for with DRAM). As their's no
> >> > > functionality hidden on the QFN88 models (except DRAM interface
> >not
> >> > > exported), it's not clever to differentiate them. So I will use
> >suniv as
> >> > > common name of all these SoCs.
> >> > 
> >> > Where is that suniv prefix coming from?
> >> 
> >> The BSP (Melis and Linux). (e.g. "libs/suniv" directory of the Melis
> >SDK and 
> >> "arch/arm/boot/dts/sunivw1p1.dtsi" in the Linux SDK)
> >
> >Do you have a link to that BSP?
> 
> I have it on the Baidu Pan. Is it acceptable?

Yep, it's not crazy fast but it works :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/18006b5f/attachment.sig>
