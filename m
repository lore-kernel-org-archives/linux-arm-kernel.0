From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Jul 2015 10:57:13 +0200
Subject: [linux-sunxi] Re: [PATCH 2/3] ARM: dts: axp152: Add a dtsi file
 for the axp152 pmic
In-Reply-To: <558D0BC2.10004@redhat.com>
References: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
 <1435088503-20776-3-git-send-email-hdegoede@redhat.com>
 <20150625174027.GF2266@lukather> <558D0BC2.10004@redhat.com>
Message-ID: <20150706085713.GE3269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 26, 2015 at 10:22:26AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 25-06-15 19:40, Maxime Ripard wrote:
> >Hi,
> >
> >On Tue, Jun 23, 2015 at 09:41:42PM +0200, Hans de Goede wrote:
> >>From: Michal Suchanek <hramrach@gmail.com>
> >>
> >>Add a dtsi file for the axp152 pmic, this mirrors the way things are
> >>handled for the axp202 pmic.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  arch/arm/boot/dts/axp152.dtsi | 49 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 49 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/axp152.dtsi
> >
> >Unfortunately, Mark expressed clearly that he didn't want such files.
> 
> That is not how I remember the discussion, he said that he did not consider
> them useful, we explained why we do consider them useful for the sunxi
> case and then things went quiet.
> 
> And we do already have an axp209.dtsi, and I find having that useful
> for enabling the regulators on axp209 using boards.

Hmmm, reading this discussion again, it indeed looks like I
misremembered what he was saying.

> Ultimately it is your call, but I really think we should be consistent
> and add an axp152.dtsi to mirror how we do things with the axp209.

Was there any other comments on this serie (and are you going to send
a v2?) or should I apply this patch?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/92db4319/attachment.sig>
