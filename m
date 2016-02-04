From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 17:44:38 +0100
Subject: [PATCH 10/11] ARM: dts: sun9i: a80-optimus: Disable dummy
 regulators vcc3v0, vcc3v3, vcc5v0
In-Reply-To: <CAGb2v66xjgsoVEBocUfDk6DDx4QcH-4pP94v+4FHLTJ=rii09Q@mail.gmail.com>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-11-git-send-email-wens@csie.org>
 <20160202162136.GX4652@lukather>
 <CAGb2v66xjgsoVEBocUfDk6DDx4QcH-4pP94v+4FHLTJ=rii09Q@mail.gmail.com>
Message-ID: <20160204164438.GJ4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 12:41:37AM +0800, Chen-Yu Tsai wrote:
> On Wed, Feb 3, 2016 at 12:21 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Tue, Feb 02, 2016 at 06:27:43PM +0800, Chen-Yu Tsai wrote:
> >> These 3 regulators are provided in sunxi-common-regulators.dtsi.
> >> 3.0V/3.3V and 5.0V are commonly used voltages in Allwinner devices.
> >> These dummy regulators provide a stand-in when bindings that require
> >> one, but the real regulator is not supported yet.
> >>
> >> Since these are no longer needed, we can disable them.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Why not remove the include entirely then?
> 
> reg_vbus* are still used. Or should we move them as well?

I think so yeah. It's totally fine to disable per-boards regulators.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/87bf6d46/attachment-0001.sig>
